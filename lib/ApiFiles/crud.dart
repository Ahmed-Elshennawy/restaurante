import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error : ${response.statusCode}");
      }
    } catch (e) {
      print("catched error : ${e}");
    }
  }

  postRequest(String url, Map data) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("error : ${response.statusCode}");
      }
    } catch (e) {
      print("catched error : ${e}");
    }
  }

  postRequestFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));

    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error : ${myrequest.statusCode}");
    }
  }
}
