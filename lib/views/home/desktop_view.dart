import 'package:clean_city/shared/shared.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageController2 = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      width: width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avec nous, soyez des défenseurs de l'environnement!",
                            style: GoogleFonts.abrilFatface(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(
                            height: width * 0.2,
                            child: PageView.builder(
                              itemCount: MainData.titles.length,
                              controller: _pageController2,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (value) {
                                currentPage = value;
                              },
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      MainData.titles[index],
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w600,
                                        fontSize: width * 0.02,
                                      ),
                                    ),
                                    Text(
                                      MainData.desc[index],
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.w300,
                                        fontSize: width * 0.012,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          CustomAppButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddClientForm();
                                },
                              );
                            },
                            text: "S'abonner",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 400,
                            child: PageView.builder(
                              itemCount: MainData.images.length,
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (value) {
                                currentPage = value;
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  width: width * 0.6,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(MainData.images[index]),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Gap(15),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: MainData.images.length,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.black,
                              dotColor: Colors.black26,
                              spacing: 3,
                              expansionFactor: 2,
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.1,
                            ),
                            child: socialmediaView(context),
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      currentPage > 0 ? currentPage - 1 : 0,
                      duration: const Duration(microseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                    _pageController2.animateToPage(
                      currentPage > 0 ? currentPage - 1 : 0,
                      duration: const Duration(microseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(HugeIcons.strokeRoundedArrowLeft02),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      currentPage < MainData.images.length
                          ? currentPage + 1
                          : MainData.images.length - 1,
                      duration: const Duration(microseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                    _pageController2.animateToPage(
                      currentPage < MainData.images.length
                          ? currentPage + 1
                          : MainData.titles.length - 1,
                      duration: const Duration(microseconds: 1500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(HugeIcons.strokeRoundedArrowRight02),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
