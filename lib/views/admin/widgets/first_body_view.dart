import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../admin_screen.dart';
import '../pages/clients_list.dart';
import '../pages/deposits_list.dart';
import '../pages/employers_list.dart';

class FirstBodyView extends StatefulWidget {
  const FirstBodyView({super.key});

  @override
  State<FirstBodyView> createState() => _FirstBodyViewState();
}

class _FirstBodyViewState extends State<FirstBodyView> {
  bool isHovered = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return !AppAdaptability.isMobile(context)
        ? Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onHover: (value) {
                          setState(() {
                            currentIndex = index;
                            isHovered = !isHovered;
                          });
                        },
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClientsList(),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmployersList(),
                              ),
                            );
                          } else if (index == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DepositsList(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          decoration: BoxDecoration(
                            color: isHovered && currentIndex == index
                                ? Colors.grey.shade400
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            DashBoardData.titles[index],
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (index != 2) Gap(20),
                  ],
                ),
              ),
            ),
          )
        : Column(
            children: List.generate(
              3,
              (index) => Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onHover: (value) {
                      setState(() {
                        currentIndex = index;
                        isHovered = !isHovered;
                      });
                    },
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ClientsList(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmployersList(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DepositsList(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: BoxDecoration(
                        color: isHovered && currentIndex == index
                            ? Colors.grey.shade400
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        DashBoardData.titles[index],
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          );
  }
}
