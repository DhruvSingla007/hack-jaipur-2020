import 'package:flutter/material.dart';
import 'package:hackjaipur2020/pages/splash_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(),
      title: 'App',
    );
  }
}
