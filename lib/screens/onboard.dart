import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/dark_theme_provider.dart';
import '/screens/login.dart';
import '../widgets/reused.dart';
import '../widgets/reused_model.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            contents[i].image,
                            height: 400,
                            width: MediaQuery.of(context).size.width / 1.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Text(contents[i].title,
                            style: themeState.getDarkTheme
                                ? AppWidget.platesDark()
                                : AppWidget.platesLight()),
                        const SizedBox(height: 20.0),
                        Text(contents[i].description,
                            style: themeState.getDarkTheme
                                ? AppWidget.platesDark()
                                : AppWidget.platesLight()),
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => Container(
                height: 10.0,
                width: currentIndex == index ? 18 : 7,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color:
                        themeState.getDarkTheme ? Colors.white : Colors.black),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              }
              _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: themeState.getDarkTheme
                          ? Colors.white
                          : Colors.black)),
              height: 60,
              margin: const EdgeInsets.all(60.0),
              width: double.infinity,
              child: Center(
                child: Text(
                  currentIndex == contents.length - 1 ? 'Start' : 'Next',
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
