import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackjaipur2020/onboardingpages/onboarding_screen.dart';
import 'package:hackjaipur2020/pages/home_page.dart';
import 'package:hackjaipur2020/pages/login_page.dart';
import 'package:hackjaipur2020/pages/splash_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith());
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xffCBE7EA),
          appBarTheme: AppBarTheme(
            color: Color(0xffCBE7EA),
          )),
      home: HomePage(),
      title: 'App',
      debugShowCheckedModeBanner: false,
      routes: {
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
