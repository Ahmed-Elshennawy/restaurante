// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/main.dart';
import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formkey = GlobalKey<FormState>();
  String username = "", password = "";
  TextEditingController usernamecotroller = TextEditingController();
  TextEditingController passwordcotroller = TextEditingController();

  Crud crud = Crud();
  bool isLoading = false;

  login() async {
    if (_formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await crud.postRequest(linkAdminlogin, {
        "email": usernamecotroller.text,
        "password": passwordcotroller.text,
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

        Navigator.of(context)
            .pushNamedAndRemoveUntil("home_admin", (route) => false);
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
          desc: 'LogIn Failed, Email or Password is Incorrect.',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededeb),
      body: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 53, 51, 51),
                  Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                top:
                    Radius.elliptical(MediaQuery.of(context).size.width, 110.0),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Let\'s start with\nAdmin!',
                      style: AppWidget.largeLight(),
                    ),
                    const SizedBox(height: 30.0),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 45.0),
                              Container(
                                height: 60.0,
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5.0, right: 20.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 160, 160, 147),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: usernamecotroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter The Username';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Username',
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147))),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                height: 60.0,
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 5.0, right: 20.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 160, 160, 147),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: passwordcotroller,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter The Password';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 160, 160, 147),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: () async {
                                  await login();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
