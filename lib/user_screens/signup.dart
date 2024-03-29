import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ApiFiles/apiLink.dart';
import '../ApiFiles/crud.dart';
import '../widgets/reused.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  Crud crud = Crud();
  bool isLoading = false;

  signUp() async {
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
          .pushNamedAndRemoveUntil("success", (route) => false);
    } else {
      print("SignUp Failed");
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: themeState.getDarkTheme
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 16,
                        left: MediaQuery.of(context).size.width / 14,
                        right: MediaQuery.of(context).size.width / 14,
                      ),
                      child: Column(
                        children: [
                          Center(
                              child: Image.asset('images/Restaurante.webp',
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  fit: BoxFit.cover)),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 18),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.8,
                              decoration: BoxDecoration(
                                  color: themeState.getDarkTheme
                                      ? Colors.black
                                      : Colors.white,
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
                                          style: themeState.getDarkTheme
                                              ? AppWidget.largeDark()
                                              : AppWidget.largeLight()),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      TextFormField(
                                        controller: namecontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Name',
                                            hintStyle: themeState.getDarkTheme
                                                ? AppWidget.platesDark()
                                                : AppWidget.platesLight(),
                                            prefixIcon: Icon(
                                                Icons.email_outlined,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      TextFormField(
                                        controller: mailcontroller,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Email can\'t be empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: themeState.getDarkTheme
                                                ? AppWidget.platesDark()
                                                : AppWidget.platesLight(),
                                            prefixIcon: Icon(
                                                Icons.email_outlined,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              35),
                                      TextFormField(
                                        controller: passwordcontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password can\'t be empty';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: themeState.getDarkTheme
                                                ? AppWidget.platesDark()
                                                : AppWidget.platesLight(),
                                            prefixIcon: Icon(
                                                Icons.password_outlined,
                                                color: themeState.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black)),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20),
                                      GestureDetector(
                                        onTap: () async {
                                          await signUp();
                                        },
                                        child: Material(
                                          elevation: 6,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.1,
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            child: const Center(
                                              child: Text('Sign up',
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
                                style: themeState.getDarkTheme
                                    ? AppWidget.platesDark()
                                    : AppWidget.platesLight()),
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
