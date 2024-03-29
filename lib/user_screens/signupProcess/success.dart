import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child:
              Text("new account was created successfully now you can log in"),
        ),
        MaterialButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("success", (route) => false);
            },
            child: Text("Log in")),
      ]),
    );
  }
}
