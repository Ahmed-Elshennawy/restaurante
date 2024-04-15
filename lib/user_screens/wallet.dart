import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dark_theme_provider.dart';
import '../widgets/provider.dart';
import '../widgets/reused.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              shadowColor:
                  themeState.getDarkTheme ? Colors.white : Colors.black,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    'WALLET',
                    style: themeState.getDarkTheme
                        ? AppWidget.titleNameDark()
                        : AppWidget.titleNameLight(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Consumer<WalletProvider>(
              builder: (context, walletProvider, child) {
                int amount = walletProvider.amount;

                return Material(
                  elevation: 6.0,
                  shadowColor:
                      themeState.getDarkTheme ? Colors.white : Colors.black,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: themeState.getDarkTheme
                            ? Colors.black
                            : const Color(0xfff2f2f2)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'images/wallet.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 40.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Wallet',
                                style: themeState.getDarkTheme
                                    ? AppWidget.platesDark()
                                    : AppWidget.platesLight()),
                            const SizedBox(width: 5.0),
                            Text('\$$amount',
                                style: themeState.getDarkTheme
                                    ? AppWidget.platesDark()
                                    : AppWidget.platesLight()),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 60.0),
            InkWell(
              onTap: () {
                openEdit(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color:
                          themeState.getDarkTheme ? Colors.white : Colors.black,
                    )),
                child: const Center(
                  child: Text(
                    'Add money',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
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

  void openEdit(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.cancel),
                  ),
                  const SizedBox(width: 60.0),
                  const Center(
                    child: Text(
                      'Add Money',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text('Amount'),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Amount',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    int amountToAdd = int.tryParse(amountController.text) ?? 0;
                    Provider.of<WalletProvider>(context, listen: false)
                        .addToWallet(amountToAdd);
                  },
                  child: Container(
                    width: 100.0,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
