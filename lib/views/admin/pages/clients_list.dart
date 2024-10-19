// ignore_for_file: use_build_context_synchronously

import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../../../db/db.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({super.key});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
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
                    MyAppBar(),
                    const Gap(10),
                    Text(
                      "Vos clients",
                      style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    FutureBuilder(
                      future: DBServices.getClients(),
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
                          List<ClientModel> datas = [];
                          for (var d in snapshot.data!.docs) {
                            final data = d.data();
                            final client = ClientModel.fromJson(data);
                            datas.add(client);
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
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          HugeIcons.strokeRoundedUserCircle,
                                          size: 50,
                                        ),
                                        const Gap(20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${datas[index].nom} ${datas[index].postnom} ${datas[index].prenom}",
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
                                                      .strokeRoundedMapPinpoint02,
                                                  size: 20,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  datas[index].address,
                                                  style: GoogleFonts.outfit(),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Text(
                                              "Montant à payer : ${datas[index].montant}Fc",
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
                                                          return PhoneAddClientForm(
                                                            forUpdate: true,
                                                            initialValues: [
                                                              datas[index].nom,
                                                              datas[index]
                                                                  .postnom,
                                                              datas[index]
                                                                  .prenom,
                                                              datas[index]
                                                                  .age
                                                                  .toString(),
                                                              datas[index]
                                                                  .email,
                                                              datas[index]
                                                                  .num
                                                                  .toString(),
                                                              datas[index]
                                                                  .address,
                                                              datas[index]
                                                                  .montant
                                                                  .toString(),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      HugeIcons
                                                          .strokeRoundedUserEdit01,
                                                      color:
                                                          Colors.green.shade500,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      bool deleted =
                                                          await DBServices
                                                              .deleteClient(
                                                                  datas[index]
                                                                      .email);
                                                      setState(() {});
                                                      if (deleted) {
                                                        myCustomSnackBar(
                                                          context: context,
                                                          text:
                                                              "Client supprimé !",
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
                                                      color:
                                                          Colors.red.shade500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
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
                                    "Aucun client retrouvé  !",
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
                                  "Aucun client retrouvé  !",
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
                        return PhoneAddClientForm();
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
                          return AddClientForm();
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
