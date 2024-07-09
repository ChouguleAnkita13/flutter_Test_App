import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_app/controller/database_conn.dart';
import 'package:test_app/model/user_model.dart';
import 'package:test_app/theme/app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
//GlobalKey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//TextEditingController
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    dbConnection();
  }

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
                  color: const Color.fromRGBO(14, 161, 125, 1),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create your Account",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
//Name Field                         
                            Container(
                              height: 49,
                              decoration: AppTheme.boxDecoration,
                              child: TextFormField(
                                  controller: _nameController,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  cursorColor: AppTheme.primaryColor,
                                  validator: (value) {
                                    if (value!.trim().isEmpty ||
                                        value.length < 4) {
                                      return "Please Enter Name";
                                    }
                                    return null;
                                  },
                                  decoration:
                                      AppTheme.textFieldDecoration("Name")),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                            const SizedBox(
                              height: 20,
                            ),
//Confirm Password Field                         
                            Container(
                              height: 49,
                              decoration: AppTheme.boxDecoration,
                              child: TextFormField(
                                  controller: _confirmController,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  cursorColor: AppTheme.primaryColor,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  decoration: AppTheme.textFieldDecoration(
                                      "Confirm Password")),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
//Button for SignUP                          
                            ElevatedButton(
                              onPressed: () {
                                bool isValidate =
                                    _formKey.currentState!.validate();
                                if (isValidate && _termsAccepted) {
                                  log("Data inserted");
                                  setState(() {
                                    insertSignupData(
                                      UserModel(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                                  });

                                  Navigator.of(context).pop();
                                  //clear text Field Controller
                                  _nameController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Please accept the terms and conditions'),
                                  ));
                                }
                              },
                              child: Text("Sign Up",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: _termsAccepted,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _termsAccepted = value!;
                                    });
                                  },
                                ),
                                const SizedBox(width: 2),
                                Text('I accept the terms and conditions',
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 215,
                  height: 18,
                  child: Row(
                    children: [
                      Text("Already have an account? ",
                          style: Theme.of(context).textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Sign In",
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
