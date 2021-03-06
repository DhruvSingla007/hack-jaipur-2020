import 'dart:ui';
import 'package:hackjaipur2020/models/treatment_slides.dart';
import 'package:flutter/material.dart';

class Constants {
  static final String SPLASH_SCREEN = 'SPLASH_SCREEN';

  static final String AEO_DOCS = 'AEO_DOCS';

  static List<TreatmentsSlides> getTreatmentsSlides() {
    return [
      new TreatmentsSlides(
          'LOSE 5Kg in 1 MONTH',
          'assets/images/wight_plan.jpg',
          'Goal Oriented Clinically Proven Personalized Paln',
          'KNOW MORE'),
      new TreatmentsSlides('LOSE 5Kg in 1 MONTH', 'assets/images/consult.jpg',
          'Goal Oriented Clinically Proven Personalized Paln', 'TAKE TEST'),
      new TreatmentsSlides(
          'LOSE 5Kg in 1 MONTH',
          'assets/images/refer_earn.jpeg',
          'Goal Oriented Clinically Proven Personalized Paln',
          'REFER NOW'),
      new TreatmentsSlides('LOSE 5Kg in 1 MONTH', 'assets/images/doctors.jpg',
          'Goal Oriented Clinically Proven Personalized Paln', 'CONSULT NOW'),
      new TreatmentsSlides('LOSE 5Kg in 1 MONTH', 'assets/images/lab_test.jpg',
          'Goal Oriented Clinically Proven Personalized Paln', 'LAB TEST'),
    ];
  }
}

class Consts {
  static Offset svgLayersOffset = Offset(0, -134);
  static Offset svgBackgroundIconsOffst = Offset(0, 914);
  static Offset svgLayer2IconsOffst = Offset(0, 126);
  static Offset svgLayer3IconsOffst = Offset(0, 592);
}

final themeColor = Color(0xfff5a623);
final primaryColor = Color(0xff203152);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);

const kSendButtonTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Ask your question...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.black, width: 2.0),
  ),
);
