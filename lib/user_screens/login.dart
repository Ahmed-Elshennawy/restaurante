import 'package:restaurante/user_screens/navigation.dart';
import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dark_theme_provider.dart';
import 'forgotpassword.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";
  TextEditingController usermailcontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(0.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(40)),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 16,
                  left: MediaQuery.of(context).size.width / 14,
                  right: MediaQuery.of(context).size.width / 14,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Center(
                          child: Image.asset('images/Restaurante.webp',
                              width: MediaQuery.of(context).size.width / 3.5,
                              fit: BoxFit.cover)),
                      SizedBox(height: MediaQuery.of(context).size.height / 18),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.0,
                          decoration: BoxDecoration(
                              color: themeState.getDarkTheme
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        35),
                                Text('Login',
                                    style: themeState.getDarkTheme
                                        ? AppWidget.largeDark()
                                        : AppWidget.largeLight()),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        35),
                                TextFormField(
                                  controller: usermailcontroller,
                                  keyboardType: TextInputType.emailAddress,
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
                                            : Colors.black,
                                      )),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        35),
                                TextFormField(
                                  controller: userpasswordcontroller,
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
                                            : Colors.black,
                                      )),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
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
                                      child: Text('Forget Password ?',
                                          style: themeState.getDarkTheme
                                              ? AppWidget.platesDark()
                                              : AppWidget.platesLight())),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        40),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = usermailcontroller.text;
                                        password = userpasswordcontroller.text;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Navigation()));
                                      });
                                    }
                                  },
                                  child: Material(
                                    elevation: 6,
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      width: MediaQuery.of(context).size.width /
                                          2.1,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: const Center(
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        28),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 28),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Text('Don\'t have an account? Sign up',
                            style: themeState.getDarkTheme
                                ? AppWidget.platesDark()
                                : AppWidget.platesLight()),
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
