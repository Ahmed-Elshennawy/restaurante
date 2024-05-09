// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/main.dart';
import 'package:restaurante/widgets/reused.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dark_theme_provider.dart';

class CartItem {
  final String name;
  final String detail;
  final double price;
  final int quantity;
  final String image;
  final String time;

  CartItem({
    required this.name,
    required this.detail,
    required this.price,
    required this.quantity,
    required this.image,
    required this.time,
  });
}

List<dynamic> cart = [];

class Details extends StatefulWidget {
  const Details({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.time,
    super.key,
  });

  final String image, name, detail, price, time;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int itemNumbers = 1;
  double total = 0;
  @override
  void initState() {
    super.initState();
    total = double.parse(widget.price);
  }

  Crud crud = Crud();
  bool isLoading = false;
  addOrder() async {
    isLoading = true;
    setState(() {});
    var response = await crud.postRequest(linkorderAdd, {
      "order_name": widget.name,
      "order_detail": widget.detail,
      "file": widget.image,
      "id": sharedPref.getString("id"),
      "order_price": widget.price.toString(),
      "order_quantity": itemNumbers.toString(),
      "order_time": widget.time.toString(),
    });

    isLoading = false;
    setState(() {});

    if (response['status'] == 'success') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("navigation", (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 800),
          backgroundColor: Colors.black,
          content: Text(
            'Food Added to Cart',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } else {
      print("failed to add order");
    }
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
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: themeState.getDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(widget.image,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.6,
                    fit: BoxFit.cover),
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          style: themeState.getDarkTheme
                              ? AppWidget.platesDark()
                              : AppWidget.platesLight()),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (itemNumbers != 1) {
                        --itemNumbers;
                        total = total - double.parse(widget.price);
                      }
                      setState(() {});
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        child: const Icon(Icons.remove, color: Colors.white)),
                  ),
                  const SizedBox(width: 15),
                  Text(itemNumbers.toString(),
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight()),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      ++itemNumbers;
                      total = total + double.parse(widget.price);
                      setState(() {});
                    },
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: themeState.getDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        child: const Icon(Icons.add, color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(widget.detail,
                  style: themeState.getDarkTheme
                      ? AppWidget.infoDark()
                      : AppWidget.infoLight()),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Text('Delivery Time',
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight()),
                  const SizedBox(width: 20.0),
                  const Icon(
                    Icons.alarm,
                  ),
                  const SizedBox(width: 10.0),
                  Text(widget.time,
                      style: themeState.getDarkTheme
                          ? AppWidget.platesDark()
                          : AppWidget.platesLight()),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Price',
                          style: themeState.getDarkTheme
                              ? AppWidget.platesDark()
                              : AppWidget.platesLight()),
                      const SizedBox(width: 10.0),
                      Text('\$${total.toStringAsFixed(2)}',
                          style: themeState.getDarkTheme
                              ? AppWidget.platesDark()
                              : AppWidget.platesLight()),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await addOrder();
                      CartItem item = CartItem(
                        name: widget.name,
                        detail: widget.detail,
                        image: widget.image,
                        price: double.parse(widget.price),
                        quantity: itemNumbers,
                        time: widget.time,
                      );
                      cart.add(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        border: Border.all(
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text('Add to cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
