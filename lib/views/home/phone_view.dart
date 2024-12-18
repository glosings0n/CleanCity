import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/shared.dart';
import '../../main.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  "Avec nous,\nsoyez des défenseurs\nde l'environnement!",
                  style: GoogleFonts.abrilFatface(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                SizedBox(
                  height: 440,
                  child: PageView.builder(
                    itemCount: MainData.images.length,
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) => currentPage = value,
                    itemBuilder: (context, index) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 55),
                        controller: ScrollController(),
                        children: [
                          Text(
                            MainData.titles[index],
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(MainData.images[index]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80),
                            child: CustomAppButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PhoneAddClientForm();
                                  },
                                );
                              },
                              text: "S'abonner",
                            ),
                          ),
                          const Gap(20),
                          Text(
                            MainData.desc[index],
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
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
                socialmediaView(context),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      currentPage < MainData.images.length
                          ? currentPage + 1
                          : MainData.images.length - 1,
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
