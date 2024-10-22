// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/shared.dart';
import '../../../../db/db.dart';

class AddDepositForm extends StatefulWidget {
  const AddDepositForm({super.key, this.initialValues});

  final List<String>? initialValues;

  @override
  State<AddDepositForm> createState() => _AddDepositFormState();
}

class _AddDepositFormState extends State<AddDepositForm> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedLocation03,
                          size: width * 0.02,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? locationController
                                : null,
                            labelText: "Adresse du dépôts",
                            hintText: "Av. /Q. /C. ",
                            initialValue: widget.initialValues != null
                                ? widget.initialValues![1]
                                : null,
                            onChanged: widget.initialValues != null
                                ? (p0) {
                                    setState(() {
                                      widget.initialValues![1] = p0;
                                    });
                                  }
                                : null,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedBoundingBox,
                          size: width * 0.02,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? capacityController
                                : null,
                            labelText: "Capacité du dépôts en m3",
                            hintText: "20",
                            initialValue: widget.initialValues != null
                                ? widget.initialValues![2]
                                : null,
                            onChanged: widget.initialValues != null
                                ? (p0) {
                                    setState(() {
                                      widget.initialValues![2] = p0;
                                    });
                                  }
                                : null,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ],
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
                            await DBServices.addDepot(
                              DepotModel(
                                localisation: locationController.text.trim(),
                                capacity: capacityController.text.trim(),
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Dépôt ajouté !",
                            );
                            setState(() {});
                          } else {
                            await DBServices.updateDepot(
                              DepotModel(
                                id: widget.initialValues![0],
                                localisation: widget.initialValues![1],
                                capacity: widget.initialValues![2],
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

class PhoneAddDepositForm extends StatefulWidget {
  const PhoneAddDepositForm({super.key, this.initialValues});

  final List<String>? initialValues;

  @override
  State<PhoneAddDepositForm> createState() => _PhoneAddDepositFormState();
}

class _PhoneAddDepositFormState extends State<PhoneAddDepositForm> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedLocation03,
                          size: width * 0.035,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? locationController
                                : null,
                            labelText: "Adresse du dépôts",
                            hintText: "Av. /Q. /C. ",
                            initialValue: widget.initialValues != null
                                ? widget.initialValues![1]
                                : null,
                            onChanged: widget.initialValues != null
                                ? (p0) {
                                    setState(() {
                                      widget.initialValues![1] = p0;
                                    });
                                  }
                                : null,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          HugeIcons.strokeRoundedBoundingBox,
                          size: width * 0.035,
                        ),
                        Gap(20),
                        Expanded(
                          child: CustomTextField(
                            controller: widget.initialValues == null
                                ? capacityController
                                : null,
                            labelText: "Capacité du dépôts en m3",
                            hintText: "20",
                            initialValue: widget.initialValues != null
                                ? widget.initialValues![2]
                                : null,
                            onChanged: widget.initialValues != null
                                ? (p0) {
                                    setState(() {
                                      widget.initialValues![2] = p0;
                                    });
                                  }
                                : null,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ],
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
                            await DBServices.addDepot(
                              DepotModel(
                                localisation: locationController.text.trim(),
                                capacity: capacityController.text.trim(),
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Dépôt ajouté !",
                            );
                            setState(() {});
                          } else {
                            await DBServices.updateDepot(
                              DepotModel(
                                id: widget.initialValues![0],
                                localisation: widget.initialValues![1],
                                capacity: widget.initialValues![2],
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
