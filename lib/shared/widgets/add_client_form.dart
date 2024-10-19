// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../db/db.dart';
import '../shared.dart';

class AddClientForm extends StatefulWidget {
  const AddClientForm({
    super.key,
    this.initialValues,
    this.forUpdate = false,
  });

  final List<String?>? initialValues;
  final bool forUpdate;

  @override
  State<AddClientForm> createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  final TextEditingController nomCtr = TextEditingController();
  final TextEditingController postnomCtr = TextEditingController();
  final TextEditingController prenomCtr = TextEditingController();
  final TextEditingController ageCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController numCtr = TextEditingController();
  final TextEditingController adresseCtr = TextEditingController();
  final TextEditingController montantCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final controllers = [
      nomCtr,
      postnomCtr,
      prenomCtr,
      ageCtr,
      emailCtr,
      numCtr,
      adresseCtr,
      montantCtr,
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
                                widget.forUpdate && index == 4 ? false : true,
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
                          await DBServices.addClient(
                            ClientModel(
                              nom: nomCtr.text.trim(),
                              postnom: postnomCtr.text.trim(),
                              prenom: prenomCtr.text.trim(),
                              age: int.parse(ageCtr.text.trim()),
                              email: emailCtr.text.trim(),
                              num: int.parse(numCtr.text.trim()),
                              address: adresseCtr.text.trim(),
                              montant: int.parse(montantCtr.text.trim()),
                            ),
                          );
                          myCustomSnackBar(
                            context: context,
                            text: "Abonnement réussi !",
                          );
                          Navigator.pop(context);
                          registeringStarted();
                        } catch (e) {
                          myCustomSnackBar(
                            context: context,
                            text: "Abonnement échoué !",
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

class PhoneAddClientForm extends StatefulWidget {
  const PhoneAddClientForm({
    super.key,
    this.initialValues,
    this.forUpdate = false,
  });

  final List<String?>? initialValues;
  final bool forUpdate;

  @override
  State<PhoneAddClientForm> createState() => _PhoneAddClientFormState();
}

class _PhoneAddClientFormState extends State<PhoneAddClientForm> {
  final TextEditingController nomCtr = TextEditingController();
  final TextEditingController postnomCtr = TextEditingController();
  final TextEditingController prenomCtr = TextEditingController();
  final TextEditingController ageCtr = TextEditingController();
  final TextEditingController emailCtr = TextEditingController();
  final TextEditingController numCtr = TextEditingController();
  final TextEditingController adresseCtr = TextEditingController();
  final TextEditingController montantCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final List<TextEditingController> controllers = [
      nomCtr,
      postnomCtr,
      prenomCtr,
      ageCtr,
      emailCtr,
      numCtr,
      adresseCtr,
      montantCtr,
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
                          size: width * 0.035,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: controllers[index],
                            labelText: FormData.labels[index],
                            hintText: FormData.hints[index],
                            initialValue: widget.initialValues == null
                                ? null
                                : widget.initialValues![index],
                            enabled:
                                widget.forUpdate && index == 4 ? false : true,
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
                          await DBServices.addClient(
                            ClientModel(
                              nom: nomCtr.text.trim(),
                              postnom: postnomCtr.text.trim(),
                              prenom: prenomCtr.text.trim(),
                              age: int.parse(ageCtr.text.trim()),
                              email: emailCtr.text.trim(),
                              num: int.parse(numCtr.text.trim()),
                              address: adresseCtr.text.trim(),
                              montant: int.parse(montantCtr.text.trim()),
                            ),
                          );
                          myCustomSnackBar(
                            context: context,
                            text: "Abonnement réussi !",
                          );
                          Navigator.pop(context);
                          registeringStarted();
                        } catch (e) {
                          myCustomSnackBar(
                            context: context,
                            text: "Abonnement échoué !",
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

class FormData {
  static List<IconData> icons = [
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUser,
    HugeIcons.strokeRoundedUserStory,
    HugeIcons.strokeRoundedMail02,
    HugeIcons.strokeRoundedTelephone,
    HugeIcons.strokeRoundedMapPin,
    HugeIcons.strokeRoundedDollar02,
  ];

  static List<String> labels = [
    "Nom *",
    "Postnom *",
    "Prenom *",
    "Age *",
    "Email *",
    "Num (commençant par +243) *",
    "Adresse *",
    "Montant en CD *",
  ];

  static List<String> hints = [
    "",
    "",
    "",
    "20",
    "elikya@gmail.com",
    "+243844300329",
    "Av. Fizi/Q. Ndendere/C. Ibanda",
    "20000",
  ];
}
