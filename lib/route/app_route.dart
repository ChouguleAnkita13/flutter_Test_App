import 'package:flutter/material.dart';
import 'package:test_app/view/screens/dashboard.dart';
import 'package:test_app/view/screens/login.dart';
import 'package:test_app/view/screens/signup.dart';
import 'package:test_app/view/screens/splash_screen.dart';

Widget initialScreen=const SplashScreen();

Map<String, Widget Function(BuildContext)> appRoute = {
  "/login": (context) {
    return const LoginScreen();
  },
  "/singUp": (context) {
    return const SignUpScreen();
  },
  "/dashboard": (context) {
    return const DashBoard();
  }
};
