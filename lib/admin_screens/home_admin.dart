import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dark_theme_provider.dart';
import 'add_food.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Home Admin',
                style: themeState.getDarkTheme
                    ? AppWidget.largeDark()
                    : AppWidget.largeLight(),
              ),
            ),
            const SizedBox(height: 40.0),
            Material(
              elevation: 10.0,
              shadowColor:
                  themeState.getDarkTheme ? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddFood(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            'images/food.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        const Text(
                          'Add Food Items',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
