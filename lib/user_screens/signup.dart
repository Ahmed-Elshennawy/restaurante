// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:restaurante/components/custometext_form.dart';
import 'package:restaurante/components/valid.dart';
import 'package:flutter/material.dart';

import '../ApiFiles/api_link.dart';
import '../ApiFiles/crud.dart';
import '../widgets/reused.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  Crud crud = Crud();
  bool isLoading = false;

  signup() async {
    if (_formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await crud.postRequest(linkSignUp, {
        "username": namecontroller.text,
        "email": mailcontroller.text,
        "password": passwordcontroller.text
      });

      isLoading = false;
      setState(() {});

      if (response["status"] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("login", (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
              'SIGN UP Successfully',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          desc: 'Sign Up Failed, Try to Sign Up agian.',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.8),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 14,
                        right: MediaQuery.of(context).size.width / 14,
                      ),
                      child: Column(
                        children: [
                          Center(
                              child: Image.asset("images/AppLogo.jpg",
                                  width: 200, fit: BoxFit.cover)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 18),
                          Material(
                            elevation: 10.0,
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              // width: MediaQuery.of(context).size.width,
                              width: 600,
                              height: MediaQuery.of(context).size.height / 1.8,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Form(
                                key: _formkey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      Text('Sign up',
                                          style: AppWidget.largeLight()),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      CustTextFormSign(
                                        controller: namecontroller,
                                        hint: "username",
                                        valid: (value) {
                                          return validInput(value!, 3, 50);
                                        },
                                        prefix: Icons.person,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      CustTextFormSign(
                                        controller: mailcontroller,
                                        hint: "email",
                                        valid: (value) {
                                          return validMail(value!, 3, 50);
                                        },
                                        prefix: Icons.email,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      CustTextFormSign(
                                        controller: passwordcontroller,
                                        hint: "password",
                                        secureText: true,
                                        valid: (value) {
                                          return validInput(value!, 3, 50);
                                        },
                                        prefix: Icons.password,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20),
                                      GestureDetector(
                                        onTap: () async {
                                          await signup();
                                        },
                                        child: Material(
                                          elevation: 10.0,
                                          shadowColor: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: const Center(
                                              child: Text('Sign Up',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              28),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 28),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                            child: Text('Already have an account? Login',
                                style: AppWidget.platesLight()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
