import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackjaipur2020/onboardingpages/onboarding_screen.dart';
import 'package:hackjaipur2020/pages/about_page.dart';
import 'package:hackjaipur2020/pages/dashboard_page.dart';
import 'package:hackjaipur2020/pages/discussions.dart';
import 'package:hackjaipur2020/pages/extras_page.dart';
import 'package:hackjaipur2020/pages/home_page.dart';
import 'package:hackjaipur2020/pages/hospitals_page.dart';
import 'package:hackjaipur2020/pages/login_page.dart';
import 'package:hackjaipur2020/pages/medicines_page.dart';
import 'package:hackjaipur2020/pages/my_profile_page.dart';
import 'package:hackjaipur2020/pages/relax_zone_page.dart';
import 'package:hackjaipur2020/pages/splash_page.dart';

import 'minigameminesweeper/minesweeper.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith());
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xffCBE7EA),
          appBarTheme: AppBarTheme(
            color: Color(0xffCBE7EA),
          )),
      home: AnimatedSplashScreen(),
      title: 'App',
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
        MyProfilePage.routeName: (context) => MyProfilePage(),
        AboutPage.routeName: (context) => AboutPage(),
        DiscussionsPage.routeName: (context) => DiscussionsPage(),
        ExtrasPage.routeName: (context) => ExtrasPage(),
        RelaxZonePage.routeName: (context) => RelaxZonePage(),
        DashboardPage.routeName: (context) => DashboardPage(),
        MinesweeperGame.routeName: (context) => MinesweeperGame(),
        HospitalsPage.routeName: (context) => HospitalsPage(),
        MedicinesPage.routeName: (context) => MedicinesPage(),
      },
    );
  }
}
