import 'package:flutter/material.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';

class UsersOrders extends StatefulWidget {
  const UsersOrders({super.key});

  @override
  State<UsersOrders> createState() => _UsersOrdersState();
}

List<dynamic> list = [];
Crud crud = Crud();
getOrders() async {
  var response = await crud.getRequest(linkcheckorderView);
    if (response['status'] == 'success') {
      // setState(() {
        list = response['data'];
      // });
    }
}

class _UsersOrdersState extends State<UsersOrders> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
