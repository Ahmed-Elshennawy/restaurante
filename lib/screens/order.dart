import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dark_theme_provider.dart';
import '../widgets/reused.dart';
import '../widgets/provider.dart'; // Import your WalletProvider
import 'details.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String calculateTotalPrice() {
    double totalPrice = 0;
    for (CartItem item in cart) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice.toStringAsFixed(2);
  }

  int calculateTotalItems() {
    int items = 0;
    for (CartItem item in cart) {
      items += item.quantity;
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Material(
              elevation: 2.0,
              shadowColor:
                  themeState.getDarkTheme ? Colors.white : Colors.black,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    'Food Cart',
                    style: themeState.getDarkTheme
                        ? AppWidget.titleNameDark()
                        : AppWidget.titleNameLight(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Meals',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight(),
                ),
                const SizedBox(width: 20.0),
                Text(
                  '${calculateTotalItems()}',
                  style: themeState.getDarkTheme
                      ? AppWidget.platesDark()
                      : AppWidget.platesLight(),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(cart[index].name),
                    background: Container(
                      color: const Color.fromARGB(255, 115, 76, 74),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        cart.removeAt(index);
                      });
                    },
                    direction: DismissDirection.endToStart,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 7.0, right: 7.0, top: 20.0, bottom: 10.0),
                      child: Material(
                        elevation: 5.0,
                        shadowColor: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: themeState.getDarkTheme
                                          ? Colors.white
                                          : Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    cart[index].quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: themeState.getDarkTheme
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  cart[index].image,
                                  height: 95,
                                  width: 95,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart[index].name,
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                  Text(
                                    '\$${cart[index].price.toStringAsFixed(2)}',
                                    style: themeState.getDarkTheme
                                        ? AppWidget.platesDark()
                                        : AppWidget.platesLight(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
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
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                final double totalPrice = double.parse(calculateTotalPrice());
                final walletProvider =
                    Provider.of<WalletProvider>(context, listen: false);
                if (totalPrice == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text(
                        'Cart is empty',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  );
                } else if (totalPrice <= walletProvider.amount) {
                  walletProvider.amount -= totalPrice.toInt();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text(
                        'Payment Successful!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  cart.clear();
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text(
                        'No enough money in Wallet!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white)),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
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
