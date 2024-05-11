// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/admin_screens/home_admin.dart';
import 'package:restaurante/widgets/dark_theme_provider.dart';
import 'package:restaurante/widgets/reused.dart';

class UsersOrders extends StatefulWidget {
  const UsersOrders({super.key});

  @override
  State<UsersOrders> createState() => _UsersOrdersState();
}

class _UsersOrdersState extends State<UsersOrders> {
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  List<dynamic> userOrderList = [];
  Crud crud = Crud();

  getOrders() async {
    var response = await crud.getRequest(linkcheckorderView);
    if (response['status'] == 'success') {
      setState(() {
        print(response);
        userOrderList = response['data'];
      });
    }
  }

  String calculateTotalPrice() {
    double totalPrice = 0;
    for (dynamic item in userOrderList) {
      totalPrice += item['order_price'] * item['order_quantity'];
    }
    return totalPrice.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        shadowColor: themeState.getDarkTheme ? Colors.white : Colors.black,
        backgroundColor: themeState.getDarkTheme ? Colors.black : Colors.white,
        toolbarHeight: 60,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => const HomeAdmin()));
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: themeState.getDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: userOrderList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = userOrderList[index];
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Column(
                        children: [
                          Material(
                            elevation: 5.0,
                            shadowColor: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${item["order_image"]}",
                                      height: 105.0,
                                      width: 105.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 15.0),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['order_name'],
                                          style: themeState.getDarkTheme
                                              ? AppWidget.platesDark()
                                              : AppWidget.platesLight(),
                                        ),
                                        Text(
                                          item['order_detail'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: themeState.getDarkTheme
                                              ? AppWidget.infoDark()
                                              : AppWidget.infoLight(),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              "${item['order_price'].toString()} \$",
                                              style: themeState.getDarkTheme
                                                  ? AppWidget.platesDark()
                                                  : AppWidget.platesLight(),
                                            ),
                                            const SizedBox(width: 30),
                                            Text(
                                              "${item['order_quantity'].toString()} ",
                                              style: themeState.getDarkTheme
                                                  ? AppWidget.platesDark()
                                                  : AppWidget.platesLight(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight(),
                    ),
                    Text(
                      '\$${calculateTotalPrice()}',
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight(),
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
