import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import 'widgets/first_body_view.dart';
import '../../../shared/shared.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: height < 90
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyAppBar(),
                    const Gap(10),
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
    );
  }
}

class DashBoardData {
  static List<String> titles = ["Clients", "Employés", "Dépôts"];
}
