// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../shared/shared.dart';
import '../../../../db/db.dart';
import 'add_team_form.dart';

class TeamsList extends StatefulWidget {
  const TeamsList({super.key});

  @override
  State<TeamsList> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  Stream<QuerySnapshot>? teamsStream;

  @override
  void initState() {
    super.initState();
    teamsStream = DBServices.getTeams();
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
                      "Vos équipes",
                      style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    StreamBuilder<QuerySnapshot>(
                      stream: teamsStream,
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
                          List<TeamModel> datas = [];
                          for (var d in snapshot.data!.docs) {
                            final data = d.data();
                            final teams = TeamModel.fromJson(data);
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
                                                const Gap(5),
                                                Text(
                                                  "Email du Chef : ${datas[index].chiefEmail}",
                                                  style: GoogleFonts.outfit(),
                                                ),
                                                const Gap(5),
                                                if (datas[index]
                                                    .teamEmails
                                                    .isEmpty) ...{
                                                  Text(
                                                    "Membres : Aucun membre pour cette équipe",
                                                    style: GoogleFonts.outfit(),
                                                  ),
                                                } else ...{
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Membres : ",
                                                        style: GoogleFonts
                                                            .outfit(),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: List.generate(
                                                          datas[index]
                                                              .teamEmails
                                                              .length,
                                                          (i) => Text(
                                                            "${i + 1}. ${datas[index].teamEmails[i]}",
                                                            style: GoogleFonts
                                                                .outfit(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                },
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
                                                        tooltip:
                                                            "Ajouter un nouveau membre",
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return PhoneAddTeamForm(
                                                                forAddTeamMember:
                                                                    true,
                                                                teamID:
                                                                    datas[index]
                                                                        .id,
                                                                membersList: datas[
                                                                        index]
                                                                    .teamEmails,
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(
                                                          HugeIcons
                                                              .strokeRoundedUserAdd02,
                                                          color: Colors
                                                              .green.shade500,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          bool deleted =
                                                              await DBServices
                                                                  .deleteTeam(
                                                                      datas[index]
                                                                          .id!);
                                                          setState(() {});
                                                          if (deleted) {
                                                            myCustomSnackBar(
                                                              context: context,
                                                              text:
                                                                  "Equipe supprimée !",
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
                                                      return AddTeamForm(
                                                        forAddTeamMember: true,
                                                        teamID: datas[index].id,
                                                        membersList:
                                                            datas[index]
                                                                .teamEmails,
                                                      );
                                                    },
                                                  );
                                                },
                                                tooltip:
                                                    "Ajouter un nouveau membre",
                                                icon: Icon(
                                                  HugeIcons
                                                      .strokeRoundedUserAdd02,
                                                  color: Colors.green.shade500,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool deleted =
                                                      await DBServices
                                                          .deleteTeam(
                                                              datas[index].id!);
                                                  setState(() {});
                                                  if (deleted) {
                                                    myCustomSnackBar(
                                                      context: context,
                                                      text:
                                                          "Equipe supprimée !",
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
                                    "Aucune équipe retrouvée !",
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
                                  "Aucune équipe retrouvée !",
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
                        return PhoneAddTeamForm();
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
                          return AddTeamForm();
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
