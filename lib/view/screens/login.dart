import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_app/model/user_model.dart';
import 'package:test_app/theme/app_theme.dart';
import 'package:test_app/view/screens/dashboard.dart';

List<UserModel> signlist = [];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//GlobalKey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//TextEditingController
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 200,
                  width: 200,
                  color: AppTheme.primaryColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login to your Account",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
//Email Field                         
                          Container(
                            height: 49,
                            decoration: AppTheme.boxDecoration,
                            child: TextFormField(
                                controller: _emailController,
                                style: Theme.of(context).textTheme.titleSmall,
                                cursorColor: AppTheme.primaryColor,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.trim().isEmpty ||
                                      !RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                                          .hasMatch(value)) {
                                    return 'Please Enter Valid Email';
                                  }
                                  return null;
                                },
                                decoration:
                                    AppTheme.textFieldDecoration("Email")),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//Password Field                         
                          Container(
                            height: 49,
                            decoration: AppTheme.boxDecoration,
                            child: TextFormField(
                                controller: _passwordController,
                                style: Theme.of(context).textTheme.titleSmall,
                                cursorColor: AppTheme.primaryColor,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please Enter Password";
                                  }
                                  // Password must be at least 8 characters long
                                  // It must contain at least one uppercase letter, one lowercase letter, one digit, and one special character

                                  if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+={}|;\<>?,.\/~`\-\\[\]]).{8,}$')
                                      .hasMatch(value)) {
                                    return 'Please enter password with one uppercase letter, one lowercase letter, one digit,and one special character ';
                                  }
                                  return null;
                                },
                                decoration:
                                    AppTheme.textFieldDecoration("Password")),
                          ),
                          const SizedBox(height: 25),
//Button for Login                         
                          ElevatedButton(
                            onPressed: () {
                              bool loginValidated =
                                  _formKey.currentState!.validate();
                              int flag = 0;
                              if (loginValidated) {
                                for (int i = 0; i < signlist.length; i++) {
                                  log("For");
                                  log("${signlist[i].email} , ${signlist[i].password}");
                                  if (_emailController.text ==
                                          signlist[i].email &&
                                      _passwordController.text ==
                                          signlist[i].password) {
                                    Map userDetails = {
                                      'name': signlist[i].name,
                                      'email': signlist[i].email,
                                    };
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Login successful"),
                                      ),
                                    );
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => DashBoard(
                                                userDetails: userDetails)));
                                    flag = 1;
                                    break;
                                  }
                                }
                                if (flag == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "Login Failed , Invalid Credentials.."),
                                    ),
                                  );
                                  _emailController.clear();
                                  _passwordController.clear();
                                }
                              }
                            },
                            child: Text("Sign In",
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                //code to Handle forgot password
                              },
                              child: Text('Forgot Password?',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.primaryColor)),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Login With Google",
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 205,
                  height: 18,
                  child: Row(
                    children: [
                      Text("Don’t have an account? ",
                          style: Theme.of(context).textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/singUp");
                        },
                        child: Text("Sign up",
                            style: Theme.of(context).textTheme.bodyLarge),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
