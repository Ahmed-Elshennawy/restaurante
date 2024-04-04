import 'package:flutter/foundation.dart';
// import 'package:restaurante/main.dart';

class WalletProvider extends ChangeNotifier {
  int _amount = 0;

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
    notifyListeners();
  }

  void addToWallet(int value) {
    _amount += value;
    notifyListeners();
  }
}
