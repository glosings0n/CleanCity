// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/shared.dart';
import '../../../../db/db.dart';

class AddEmployerForm extends StatefulWidget {
  const AddEmployerForm({
    super.key,
    this.initialValues,
    this.forUpdate = false,
  });

  final List<String>? initialValues;
  final bool forUpdate;

  @override
  State<AddEmployerForm> createState() => _AddEmployerFormState();
}

class _AddEmployerFormState extends State<AddEmployerForm> {
  final TextEditingController prenomCtr = TextEditingController();
  final TextEditingController nomCtr = TextEditingController();
  final TextEditingController ageCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController numCtr = TextEditingController();
  final TextEditingController teamCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final controllers = [
      prenomCtr,
      nomCtr,
      ageCtr,
      emailCtr,
      numCtr,
      teamCtr,
    ];

    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.black26,
      child: Container(
        alignment: Alignment.center,
        width: width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(HugeIcons.strokeRoundedCancelCircle),
                ),
              ],
            ),
            const Gap(10),
            Text(
              "Veuillez fournir les informations ci-après :",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.02,
              ),
            ),
            const Gap(20),
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView.builder(
                  itemCount: controllers.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          FormData.icons[index],
                          size: width * 0.02,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? controllers[index]
                                : null,
                            labelText: FormData.labels[index],
                            hintText: FormData.hints[index],
                            initialValue: widget.initialValues == null
                                ? null
                                : widget.initialValues![index],
                            enabled:
                                widget.forUpdate && index == 3 ? false : true,
                            onChanged: widget.initialValues == null
                                ? null
                                : (value) {
                                    setState(() {
                                      widget.initialValues![index] = value;
                                    });
                                  },
                            keyboardType: index == 3 || index == 7
                                ? TextInputType.number
                                : index == 5
                                    ? TextInputType.phone
                                    : index == 4
                                        ? TextInputType.emailAddress
                                        : TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(20),
            isRegistering
                ? SizedBox(
                    width: AppAdaptability.isDesktop(context)
                        ? width * 0.025
                        : width * 0.05,
                    height: AppAdaptability.isDesktop(context)
                        ? width * 0.025
                        : width * 0.05,
                    child: CircularProgressIndicator(
                      color: Colors.grey.shade500,
                      strokeWidth: 2,
                    ),
                  )
                : CustomAppButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          registeringStarted();
                          if (widget.initialValues == null) {
                            await DBServices.addEmployers(
                              EmployerModel(
                                nom: nomCtr.text.trim(),
                                prenom: prenomCtr.text.trim(),
                                age: int.parse(ageCtr.text.trim()),
                                email: emailCtr.text.trim(),
                                num: int.parse(numCtr.text.trim()),
                                team: teamCtr.text.trim(),
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Employé ajouté !",
                            );
                            setState(() {});
                          } else {
                            await DBServices.updateEmployer(
                              EmployerModel(
                                prenom: widget.initialValues![0],
                                nom: widget.initialValues![1],
                                age: int.parse(widget.initialValues![2]),
                                email: widget.initialValues![3],
                                num: int.parse(widget.initialValues![4]),
                                team: widget.initialValues![5],
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Infos mises en jour !",
                            );
                            setState(() {});
                          }
                          Navigator.pop(context);
                          registeringStarted();
                        } catch (e) {
                          myCustomSnackBar(
                            context: context,
                            text: "Ajout échoué !",
                            error: true,
                          );
                          debugPrint(e.toString());
                          registeringStarted();
                        }
                      }
                    },
                    text: "Valider",
                  ),
          ],
        ),
      ),
    );
  }

  void registeringStarted() {
    setState(() {
      isRegistering = !isRegistering;
    });
  }
}

class PhoneAddEmployerForm extends StatefulWidget {
  const PhoneAddEmployerForm({
    super.key,
    this.initialValues,
    this.forUpdate = false,
  });

  final List<String>? initialValues;
  final bool forUpdate;

  @override
  State<PhoneAddEmployerForm> createState() => _PhoneAddEmployerFormState();
}

class _PhoneAddEmployerFormState extends State<PhoneAddEmployerForm> {
  final TextEditingController prenomCtr = TextEditingController();
  final TextEditingController nomCtr = TextEditingController();
  final TextEditingController ageCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController numCtr = TextEditingController();
  final TextEditingController teamCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final List<TextEditingController> controllers = [
      prenomCtr,
      nomCtr,
      ageCtr,
      emailCtr,
      numCtr,
      teamCtr,
    ];

    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: Container(
        alignment: Alignment.center,
        width: width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(HugeIcons.strokeRoundedCancelCircle),
                ),
              ],
            ),
            const Gap(10),
            Text(
              "Veuillez fournir les informations ci-après :",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.04,
              ),
            ),
            const Gap(20),
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView.builder(
                  itemCount: controllers.length,
                  itemBuilder: (_, index) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          FormData.icons[index],
                          size: width * 0.02,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? controllers[index]
                                : null,
                            labelText: FormData.labels[index],
                            hintText: FormData.hints[index],
                            initialValue: widget.initialValues == null
                                ? null
                                : widget.initialValues![index],
                            onChanged: widget.initialValues == null
                                ? null
                                : (value) {
                                    setState(() {
                                      widget.initialValues![index] = value;
                                    });
                                  },
                            enabled:
                                widget.forUpdate && index == 3 ? false : true,
                            keyboardType: index == 3 || index == 7
                                ? TextInputType.number
                                : index == 5
                                    ? TextInputType.phone
                                    : index == 4
                                        ? TextInputType.emailAddress
                                        : TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(20),
            isRegistering
                ? SizedBox(
                    width: AppAdaptability.isDesktop(context)
                        ? width * 0.025
                        : width * 0.05,
                    height: AppAdaptability.isDesktop(context)
                        ? width * 0.025
                        : width * 0.05,
                    child: CircularProgressIndicator(
                      color: Colors.grey.shade500,
                      strokeWidth: 2,
                    ),
                  )
                : CustomAppButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          registeringStarted();
                          if (widget.initialValues == null) {
                            await DBServices.addEmployers(
                              EmployerModel(
                                nom: nomCtr.text.trim(),
                                prenom: prenomCtr.text.trim(),
                                age: int.parse(ageCtr.text.trim()),
                                email: emailCtr.text.trim(),
                                num: int.parse(numCtr.text.trim()),
                                team: teamCtr.text.trim(),
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Employé ajouté !",
                            );
                            setState(() {});
                          } else {
                            await DBServices.updateEmployer(
                              EmployerModel(
                                prenom: widget.initialValues![0],
                                nom: widget.initialValues![1],
                                age: int.parse(widget.initialValues![2]),
                                email: widget.initialValues![3],
                                num: int.parse(widget.initialValues![4]),
                                team: widget.initialValues![5],
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Infos mises en jour !",
                            );
                            setState(() {});
                          }
                          Navigator.pop(context);
                          registeringStarted();
                        } catch (e) {
                          myCustomSnackBar(
                            context: context,
                            text: "Ajout échoué !",
                            error: true,
                          );
                          debugPrint(e.toString());
                          registeringStarted();
                        }
                      }
                    },
                    text: "Valider",
                  ),
            const Gap(50),
          ],
        ),
      ),
    );
  }

  void registeringStarted() {
    setState(() {
      isRegistering = !isRegistering;
    });
  }
}

class FormData {
  static List<IconData> icons = [
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUserStory,
    HugeIcons.strokeRoundedMail02,
    HugeIcons.strokeRoundedTelephone,
    HugeIcons.strokeRoundedUserMultiple,
  ];

  static List<String> labels = [
    "Prenom *",
    "Nom *",
    "Age *",
    "Email *",
    "Num (commençant par +243) *",
    "Team *",
  ];

  static List<String> hints = [
    "",
    "",
    "20",
    "elikya@gmail.com",
    "+243844300329",
    "Team-1",
  ];
}
