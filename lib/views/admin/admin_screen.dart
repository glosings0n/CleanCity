import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/first_body_view.dart';
import '../../../shared/shared.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: height < 90
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyAppBar(isOnAdmin: true),
                          const Gap(10),
                          Text(
                            "Tableau de Bord",
                            style: GoogleFonts.abrilFatface(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          Expanded(
                            child: ListView(
                              children: [
                                //Clients, Employers and Depots view
                                FirstBodyView(),
                                //Quantity of waste (Chart view)
                                Container(),
                                //Histories view
                                Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.25,
                    color: Colors.grey.shade400,
                    padding: EdgeInsets.only(
                      top: 20,
                      left: width * 0.12,
                      right: width * 0.12,
                    ),
                    child: Column(
                      children: [
                        socialmediaView(context),
                        const Gap(10),
                        Text(
                          "copyright©2024",
                          style: GoogleFonts.outfit(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class DashBoardData {
  static List<String> titles = ["Clients", "Employés", "Equipes", "Dépôts"];
  static List<String> titles1 = ["Clients", "Employés"];
  static List<String> titles2 = ["Equipes", "Dépôts"];
}
