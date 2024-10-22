// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/shared.dart';
import '../../../../db/db.dart';
import 'add_employer_form.dart';

class EmployersList extends StatefulWidget {
  const EmployersList({super.key});

  @override
  State<EmployersList> createState() => _EmployersListState();
}

class _EmployersListState extends State<EmployersList> {
  Stream<QuerySnapshot>? employersStream;

  @override
  void initState() {
    super.initState();
    employersStream = DBServices.getEmployers();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: height < 130
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    MyAppBar(isOnAdmin: true),
                    const Gap(10),
                    Text(
                      "Vos employés",
                      style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    StreamBuilder<QuerySnapshot>(
                      stream: employersStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade200,
                              color: Colors.grey.shade500,
                              minHeight: 3,
                              valueColor: AlwaysStoppedAnimation(
                                Colors.grey.shade500,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<EmployerModel> datas = [];
                          for (var d in snapshot.data!.docs) {
                            final data = d.data();
                            final employers = EmployerModel.fromJson(data);
                            datas.add(employers);
                          }
                          if (datas.isNotEmpty) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: datas.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.all(
                                      AppAdaptability.isDesktop(context)
                                          ? 20
                                          : 10,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              HugeIcons.strokeRoundedUserCircle,
                                              size: AppAdaptability.isDesktop(
                                                      context)
                                                  ? 100
                                                  : 50,
                                            ),
                                            Gap(
                                              AppAdaptability.isDesktop(context)
                                                  ? 25
                                                  : 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${datas[index].prenom} ${datas[index].nom}",
                                                  style: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "Age : ${datas[index].age}",
                                                  style: GoogleFonts.outfit(),
                                                ),
                                                const Gap(5),
                                                Text(
                                                  "Email : ${datas[index].email}",
                                                  style: GoogleFonts.outfit(),
                                                ),
                                                Text(
                                                  "N° Téléphone : ${datas[index].num}",
                                                  style: GoogleFonts.outfit(),
                                                ),
                                                const Gap(8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      HugeIcons
                                                          .strokeRoundedUserMultiple02,
                                                      size: 20,
                                                    ),
                                                    const Gap(5),
                                                    Text(
                                                      "Equipe : ${datas[index].team}",
                                                      style:
                                                          GoogleFonts.outfit(),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(8),
                                                if (!(AppAdaptability.isDesktop(
                                                    context)))
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(HugeIcons
                                                            .strokeRoundedMailSend02),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return PhoneAddEmployerForm(
                                                                forUpdate: true,
                                                                initialValues: [
                                                                  datas[index]
                                                                      .prenom,
                                                                  datas[index]
                                                                      .nom,
                                                                  datas[index]
                                                                      .age
                                                                      .toString(),
                                                                  datas[index]
                                                                      .email,
                                                                  datas[index]
                                                                      .num
                                                                      .toString(),
                                                                  datas[index]
                                                                      .team,
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(
                                                          HugeIcons
                                                              .strokeRoundedUserEdit01,
                                                          color: Colors
                                                              .green.shade500,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          bool deleted =
                                                              await DBServices
                                                                  .deleteEmployer(
                                                                      datas[index]
                                                                          .email);
                                                          setState(() {});
                                                          if (deleted) {
                                                            myCustomSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Employé supprimé !",
                                                            );
                                                          } else {
                                                            myCustomSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Suppression échoué !",
                                                            );
                                                          }
                                                        },
                                                        icon: Icon(
                                                          HugeIcons
                                                              .strokeRoundedDelete02,
                                                          color: Colors
                                                              .red.shade500,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),
                                        if ((AppAdaptability.isDesktop(
                                            context)))
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  HugeIcons
                                                      .strokeRoundedMailSend02,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AddEmployerForm(
                                                        forUpdate: true,
                                                        initialValues: [
                                                          datas[index].prenom,
                                                          datas[index].nom,
                                                          datas[index]
                                                              .age
                                                              .toString(),
                                                          datas[index].email,
                                                          datas[index]
                                                              .num
                                                              .toString(),
                                                          datas[index].team,
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  HugeIcons
                                                      .strokeRoundedUserEdit01,
                                                  color: Colors.green.shade500,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool deleted =
                                                      await DBServices
                                                          .deleteEmployer(
                                                              datas[index]
                                                                  .email);
                                                  setState(() {});
                                                  if (deleted) {
                                                    myCustomSnackBar(
                                                      context: context,
                                                      text:
                                                          "Employé supprimé !",
                                                    );
                                                  } else {
                                                    myCustomSnackBar(
                                                      context: context,
                                                      text:
                                                          "Suppression échoué !",
                                                    );
                                                  }
                                                },
                                                icon: Icon(
                                                  HugeIcons
                                                      .strokeRoundedDelete02,
                                                  color: Colors.red.shade500,
                                                ),
                                              ),
                                            ],
                                          )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: Text(
                                    "Aucun employé retrouvé  !",
                                    style: GoogleFonts.outfit(),
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Text(
                                  "Aucun employé retrouvé  !",
                                  style: GoogleFonts.outfit(),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: height < 130
          ? null
          : AppAdaptability.isMobile(context)
              ? FloatingActionButton.small(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PhoneAddEmployerForm();
                      },
                    );
                  },
                  backgroundColor: Colors.grey.shade200,
                  splashColor: Colors.grey.shade500,
                  hoverColor: Colors.grey.shade400,
                  child: Icon(HugeIcons.strokeRoundedAdd01),
                )
              : SizedBox(
                  height: 50,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddEmployerForm();
                        },
                      );
                    },
                    backgroundColor: Colors.grey.shade200,
                    splashColor: Colors.grey.shade500,
                    hoverColor: Colors.grey.shade400,
                    icon: Icon(HugeIcons.strokeRoundedAdd01),
                    label: Text(
                      "Ajouter",
                      style: GoogleFonts.outfit(),
                    ),
                  ),
                ),
    );
  }
}
