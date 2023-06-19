import 'package:flutter/material.dart';
import 'package:pfeflutter/screens/fichedepaie.dart';

import 'package:pfeflutter/screens/homee.dart';
import 'package:pfeflutter/screens/loading.dart';
import 'package:pfeflutter/screens/register.dart';
import 'package:pfeflutter/screens/test.dart';
import 'package:pfeflutter/screens/testssss.dart';
import 'screens/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bustraffic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Bustraffic '),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(children: [
          Image.asset('logo4.png'),
          const Text(
            'iBenvenue',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
          )
        ]),
        backgroundColor: Colors.white,
        splashIconSize: 250,
        duration: 4000,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        nextScreen: HomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
