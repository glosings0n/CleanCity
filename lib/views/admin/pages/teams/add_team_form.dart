// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/shared.dart';
import '../../../../data/data.dart';

class AddTeamForm extends StatefulWidget {
  const AddTeamForm({
    super.key,
    this.teamID,
    this.membersList,
    this.forAddTeamMember = false,
  });

  final String? teamID;
  final List? membersList;
  final bool forAddTeamMember;

  @override
  State<AddTeamForm> createState() => _AddTeamFormState();
}

class _AddTeamFormState extends State<AddTeamForm> {
  final TextEditingController emailController = TextEditingController();
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
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedMail02,
                      size: width * 0.02,
                    ),
                    Gap(20),
                    Expanded(
                      child: CustomTextField(
                        controller: emailController,
                        labelText: widget.forAddTeamMember
                            ? "Email du membre"
                            : "Email du chef de l'équipe",
                        hintText: "yseult2004@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Gap(20),
                  ],
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
                          if (!widget.forAddTeamMember) {
                            await TeamsServices.addTeam(
                              TeamModel(
                                chiefEmail: emailController.text.trim(),
                                teamEmails: [],
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Equipe ajoutée !",
                            );
                            setState(() {});
                          } else {
                            widget.membersList!
                                .add(emailController.text.trim());
                            await TeamsServices.addTeamMember(
                              widget.teamID!,
                              widget.membersList!,
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Membre ajouté !",
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

class PhoneAddTeamForm extends StatefulWidget {
  const PhoneAddTeamForm({
    super.key,
    this.teamID,
    this.membersList,
    this.forAddTeamMember = false,
  });
  final String? teamID;
  final List? membersList;
  final bool forAddTeamMember;

  @override
  State<PhoneAddTeamForm> createState() => _PhoneAddTeamFormState();
}

class _PhoneAddTeamFormState extends State<PhoneAddTeamForm> {
  final TextEditingController emailController = TextEditingController();
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
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedMail02,
                      size: width * 0.035,
                    ),
                    Gap(20),
                    Expanded(
                      child: CustomTextField(
                        controller: emailController,
                        labelText: widget.forAddTeamMember
                            ? "Email du membre"
                            : "Email du chef de l'équipe",
                        hintText: "yseult2004@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Gap(20),
                  ],
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
                          if (!widget.forAddTeamMember) {
                            await TeamsServices.addTeam(
                              TeamModel(
                                chiefEmail: emailController.text.trim(),
                                teamEmails: [],
                              ),
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Equipe ajoutée !",
                            );
                            setState(() {});
                          } else {
                            widget.membersList!
                                .add(emailController.text.trim());
                            await TeamsServices.addTeamMember(
                              widget.teamID!,
                              widget.membersList!,
                            );
                            myCustomSnackBar(
                              context: context,
                              text: "Membre ajouté !",
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
