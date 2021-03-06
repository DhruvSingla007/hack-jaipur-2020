import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:flutter/material.dart';

import 'package:hackjaipur2020/onboardingpages/page_one.dart';
import 'package:hackjaipur2020/onboardingpages/page_two.dart';
import 'package:hackjaipur2020/onboardingpages/page_three.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding-screen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  UpdateType updateType;

  final pages = [
    Container(child: PageOne()),
    Container(
      child: PageTwo(),
    ),
    Container(
      child: PageThree(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 500,
        enableSlideIcon: true,
        enableLoop: false,
        positionSlideIcon: 0.744,
        waveType: WaveType.liquidReveal,
        slideIconWidget: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Color(0xff546E7A),
        ),
        initialPage: 0,
      ),
    );
  }
}
