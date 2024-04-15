import 'package:flutter/material.dart';

class AddOrders extends StatefulWidget {
  AddOrders({Key? key}) : super(key: key);

  @override
  State<AddOrders> createState() => _AddOrders();
}

class _AddOrders extends State<AddOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Orders"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
