// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/admin_screens/admin_login.dart';
import 'package:restaurante/components/custometext_form.dart';
import 'package:restaurante/components/valid.dart';
import 'package:restaurante/main.dart';
import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';

import 'forgotpassword.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usermailcontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Crud crud = Crud();
  bool isLoading = false;

  login() async {
    if (_formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await crud.postRequest(linklogin, {
        "email": usermailcontroller.text,
        "password": userpasswordcontroller.text,
      });

      isLoading = false;
      setState(() {});

      if (response["status"] == "success") {
        sharedPref.setString("id", response['data']['id'].toString());
        sharedPref.setString("username", response['data']['username']);
        sharedPref.setString("email", response['data']['email']);
        sharedPref.setString(
            "wallet_palance", response['data']['wallet_palance'].toString());
        sharedPref.setString(
            "profile_pic_name", response['data']['profile_pic_name']);
        sharedPref.setString("theme", response['data']['theme'].toString());

        Navigator.of(context)
            .pushNamedAndRemoveUntil("navigation", (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: Text(
              'LogIn Successfully',
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
          desc: 'Log In Failed, Email or Password is Incorrect.',
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
                      color: Colors.black,
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
                        left: MediaQuery.of(context).size.width / 13,
                        right: MediaQuery.of(context).size.width / 13,
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "images/AppLogo.jpg",
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 28),
                            Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(20),
                              shadowColor: Colors.black,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                width: 600,
                                height:
                                    MediaQuery.of(context).size.height / 1.8,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      Text('Login',
                                          style: AppWidget.largeLight()),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      CustTextFormSign(
                                        controller: usermailcontroller,
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
                                        controller: userpasswordcontroller,
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
                                              35),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ForgotPassword()));
                                        },
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Forget Password ?',
                                            style: AppWidget.platesLight(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40),
                                      GestureDetector(
                                        onTap: () async {
                                          await login();
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
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: const Center(
                                              child: Text(
                                                'LOGIN',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 28),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: Text('Don\'t have an account? Sign up',
                                  style: AppWidget.platesLight()),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 28),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminLogin()));
                              },
                              child: Text('Login As admin',
                                  style: AppWidget.platesLight()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
