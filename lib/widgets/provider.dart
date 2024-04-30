import 'package:flutter/foundation.dart';
import 'package:restaurante/components/editWallet.dart';
import 'package:restaurante/main.dart';

class WalletProvider extends ChangeNotifier {
  int _amount = int.parse(sharedPref.getString("wallet_palance")!);
  int get amount => _amount;

  set amount(int value) {
    _amount = value;
    notifyListeners();
  }

  void addToWallet(int value) {
    _amount += value;
    editWallet(_amount);
    notifyListeners();
  }
}
