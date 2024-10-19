import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import 'desktop_view.dart';
import 'phone_view.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: height < 130
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyAppBar(),
                    const Gap(10),
                    AppAdaptability.isDesktop(context)
                        ? DesktopView()
                        : PhoneView()
                  ],
                ),
        ),
      ),
    );
  }
}
