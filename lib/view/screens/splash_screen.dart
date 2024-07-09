import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // Navigate to the next screen after the splash screen duration
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 144,
          width: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(234, 238, 235, 1),
          ),
          child: Image.asset(
            "assets/images/logo.png",
            height: 144,
            width: 144,
            color:AppTheme.primaryColor
          ),
        ),
      ),
    );
  }
}
