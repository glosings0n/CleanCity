// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/shared.dart';
import '../../../../data/data.dart';
import 'add_deposits_form.dart';

class DepositsList extends StatefulWidget {
  const DepositsList({super.key});

  @override
  State<DepositsList> createState() => _DepositsListState();
}

class _DepositsListState extends State<DepositsList> {
  Stream<QuerySnapshot>? depositsStream;

  @override
  void initState() {
    super.initState();
    depositsStream = DepositsServices.getDepots();
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
                      "Vos dépôts",
                      style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    StreamBuilder<QuerySnapshot>(
                      stream: depositsStream,
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
                          List<DepotModel> datas = [];
                          for (var d in snapshot.data!.docs) {
                            final data = d.data();
                            final teams = DepotModel.fromJson(data);
                            datas.add(teams);
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
                                              HugeIcons
                                                  .strokeRoundedUserMultiple,
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
                                                const Gap(5),
                                                Text(
                                                  datas[index].id!,
                                                  style: GoogleFonts.outfit(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Gap(8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      HugeIcons
                                                          .strokeRoundedLocation03,
                                                      size: 20,
                                                    ),
                                                    const Gap(5),
                                                    Text(
                                                      datas[index].localisation,
                                                      style:
                                                          GoogleFonts.outfit(),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(8),
                                                Text(
                                                  "Capacité de ${datas[index].capacity} m3",
                                                  style: GoogleFonts.outfit(),
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
                                                              return PhoneAddDepositForm(
                                                                initialValues: [
                                                                  datas[index]
                                                                      .id!,
                                                                  datas[index]
                                                                      .localisation,
                                                                  datas[index]
                                                                      .capacity,
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
                                                              await DepositsServices
                                                                  .deleteDepot(
                                                                      datas[index]
                                                                          .id!);
                                                          setState(() {});
                                                          if (deleted) {
                                                            myCustomSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Dépôt supprimé !",
                                                            );
                                                          } else {
                                                            myCustomSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Suppression échouée !",
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
                                                      return AddDepositForm(
                                                        initialValues: [
                                                          datas[index].id!,
                                                          datas[index]
                                                              .localisation,
                                                          datas[index].capacity,
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
                                                      await DepositsServices
                                                          .deleteDepot(
                                                              datas[index].id!);
                                                  setState(() {});
                                                  if (deleted) {
                                                    myCustomSnackBar(
                                                      context: context,
                                                      text: "Dépôt supprimé !",
                                                    );
                                                  } else {
                                                    myCustomSnackBar(
                                                      context: context,
                                                      text:
                                                          "Suppression échouée !",
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
                                    "Aucun dépôt retrouvé !",
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
                                  "Aucun dépôt retrouvé !",
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
                        return PhoneAddDepositForm();
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
                          return AddDepositForm();
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
