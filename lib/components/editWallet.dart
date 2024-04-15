import 'package:restaurante/ApiFiles/apiLink.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/main.dart';

Crud crud = Crud();

editWallet(int _amount) async {
  var response = await crud.postRequest(linkEditWallet,
      {"wallet_palance": _amount.toString(), "id": sharedPref.getString("id")});

  if (response["status"] == "success") {
    sharedPref.setString("wallet_palance", _amount.toString());

    print("success");
  } else {
    print("fail");
  }
}
