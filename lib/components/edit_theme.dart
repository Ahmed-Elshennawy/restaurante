import 'package:restaurante/ApiFiles/api_link.dart';
import 'package:restaurante/ApiFiles/crud.dart';
import 'package:restaurante/main.dart';

Crud crud = Crud();

editTheme(bool value) async {
  var response = await crud.postRequest(linkEditTheme,
      {"theme": value == false ? "0" : "1", "id": sharedPref.getString("id")});

  if (response["status"] == "success") {
    sharedPref.setString("theme", value == false ? "0" : "1");
  }
}
