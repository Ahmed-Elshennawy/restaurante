import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:restaurante/widgets/reused.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController controller;
  final bool secureText;

  const CustTextFormSign({
    super.key,
    required this.hint,
    required this.controller,
    required this.valid,
    this.secureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return TextFormField(
      controller: controller,
      validator: valid,
      obscureText: secureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: themeState.getDarkTheme
            ? AppWidget.platesDark()
            : AppWidget.platesLight(),
        prefixIcon: Icon(
          Icons.password_outlined,
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
