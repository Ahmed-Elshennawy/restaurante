// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/main.dart';
import 'dart:io';
import '../ApiFiles/crud.dart';
import '../customer_support/custumer_support.dart';
import '../widgets/dark_theme_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? myFile;

  bool? isLoading = false;
  Crud crud = Crud();
  Future uploadImage() async {
    XFile? xfile = await _picker.pickImage(source: ImageSource.gallery);
    myFile = File(xfile!.path);

    isLoading = true;
    setState(() {});
    var response = await crud.postRequestFile(
        linkImageUplaod,
        {
          "id": sharedPref.getString("id").toString(),
        },
        myFile!);

    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      sharedPref.setString("profile_pic_name", response['0']);
    }
  }

  deleteAccount() async {
    var response = await crud.postRequest(linkUserDelete, {
      "id": sharedPref.getString("id").toString(),
      "file": sharedPref.getString("profile_pic_name"),
    });

    if (response["status"] == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text(
            'Account Deleted Successfully',
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
        desc: 'Can\'t delete the account now, please try again later',
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  height: MediaQuery.of(context).size.height / 3.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width,
                        105.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await uploadImage();
                  },
                  child: sharedPref.getString("profile_pic_name") == ""
                      ? Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4.5,
                            left: MediaQuery.of(context).size.width / 2.9,
                          ),
                          child: Material(
                            elevation: 10.0,
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(60.0),
                            color: themeState.getDarkTheme
                                ? Colors.black
                                : Colors.white,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 35.0,
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4.5,
                            left: MediaQuery.of(context).size.width / 2.9,
                          ),
                          child: Material(
                            elevation: 10.0,
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(60.0),
                            color: themeState.getDarkTheme
                                ? Colors.black
                                : Colors.white,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  "$linkImageRoot/${sharedPref.getString("profile_pic_name")}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sharedPref.getString("username").toString(),
                        style: GoogleFonts.aboreto(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 25.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              // color: themeState.getDarkTheme ? Colors.black : Colors.white,
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 5.0,
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            sharedPref.getString("username").toString(),
                            style: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 5.0,
                shadowColor:
                    themeState.getDarkTheme ? Colors.white : Colors.black,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        themeState.getDarkTheme ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            sharedPref.getString("email").toString(),
                            style: TextStyle(
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () async {},
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  shadowColor:
                      themeState.getDarkTheme ? Colors.white : Colors.black,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          themeState.getDarkTheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("home_admin", (route) => false);
              },
              child: sharedPref.getString("email") == "admin@gmail.com"
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 10.0,
                              ),
                              decoration: BoxDecoration(
                                color: themeState.getDarkTheme
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.admin_panel_settings,
                                    color: themeState.getDarkTheme
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  const SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Admin Page',
                                        style: TextStyle(
                                          color: themeState.getDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await deleteAccount();
                  sharedPref.clear();
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  shadowColor:
                      themeState.getDarkTheme ? Colors.white : Colors.black,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          themeState.getDarkTheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delete Account',
                              style: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  sharedPref.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  shadowColor:
                      themeState.getDarkTheme ? Colors.white : Colors.black,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color:
                          themeState.getDarkTheme ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LogOut',
                              style: TextStyle(
                                color: themeState.getDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const CustomerSupport()));
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.support_agent,
          size: 30,
        ),
      ),
    );
  }
}
