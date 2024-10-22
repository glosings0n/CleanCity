import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';
import '../admin_screen.dart';

class FirstBodyView extends StatefulWidget {
  const FirstBodyView({super.key, this.lengths});

  final List? lengths;

  @override
  State<FirstBodyView> createState() => _FirstBodyViewState();
}

class _FirstBodyViewState extends State<FirstBodyView> {
  bool isHovered1 = false;
  bool isHovered2 = false;
  int currentIndex1 = 0;
  int currentIndex2 = 0;
  @override
  Widget build(BuildContext context) {
    return AppAdaptability.isDesktop(context)
        ? Row(
            children: List.generate(
              4,
              (index) => Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onHover: (value) {
                          setState(() {
                            currentIndex1 = index;
                            isHovered1 = !isHovered1;
                          });
                        },
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, "/clients");
                          } else if (index == 1) {
                            Navigator.pushNamed(context, "/employers");
                          } else if (index == 2) {
                            Navigator.pushNamed(context, "/equipes");
                          } else if (index == 3) {
                            Navigator.pushNamed(context, "/depots");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          decoration: BoxDecoration(
                            color: isHovered1 && currentIndex1 == index
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
                    if (index != 3) Gap(20),
                  ],
                ),
              ),
            ),
          )
        : AppAdaptability.isTablet(context)
            ? Column(
                children: [
                  Row(
                    children: List.generate(
                      2,
                      (index1) => Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onHover: (value) {
                                  setState(() {
                                    currentIndex1 = index1;
                                    isHovered1 = !isHovered1;
                                  });
                                },
                                onTap: () {
                                  if (index1 == 0) {
                                    Navigator.pushNamed(context, "/clients");
                                  } else if (index1 == 1) {
                                    Navigator.pushNamed(context, "/employers");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: isHovered1 && currentIndex1 == index1
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    DashBoardData.titles1[index1],
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (index1 != 1) Gap(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: List.generate(
                      2,
                      (index2) => Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onHover: (value) {
                                  setState(() {
                                    currentIndex2 = index2;
                                    isHovered2 = !isHovered2;
                                  });
                                },
                                onTap: () {
                                  if (index2 == 0) {
                                    Navigator.pushNamed(context, "/equipes");
                                  } else if (index2 == 1) {
                                    Navigator.pushNamed(context, "/depots");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: isHovered2 && currentIndex2 == index2
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    DashBoardData.titles2[index2],
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (index2 != 1) Gap(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: List.generate(
                  4,
                  (index) => Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onHover: (value) {
                          setState(() {
                            currentIndex1 = index;
                            isHovered1 = !isHovered1;
                          });
                        },
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, "/clients");
                          } else if (index == 1) {
                            Navigator.pushNamed(context, "/employers");
                          } else if (index == 2) {
                            Navigator.pushNamed(context, "/equipes");
                          } else if (index == 3) {
                            Navigator.pushNamed(context, "/depots");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          decoration: BoxDecoration(
                            color: isHovered1 && currentIndex1 == index
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
