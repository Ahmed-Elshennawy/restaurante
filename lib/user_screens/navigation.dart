import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'order.dart';
import 'profile.dart';
import 'wallet.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTabIndex = 0;
  late List<Widget> pages;
  late List<Widget> currentPage;
  late Home homepage;
  late Profile profile;
  late Order order;
  late Wallet wallet;

  @override
  void initState() {
    homepage = const Home();
    profile = const Profile();
    order = const Order();
    wallet = const Wallet();
    pages = [homepage, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (int value) {
            setState(() {
              currentTabIndex = value;
            });
          },
          items: const [
            Icon(Icons.home_outlined, color: Colors.white),
            Icon(Icons.shopping_bag_outlined, color: Colors.white),
            Icon(Icons.wallet_outlined, color: Colors.white),
            Icon(Icons.person_outline, color: Colors.white),
          ]),
      body: pages[currentTabIndex],
    );
  }
}
