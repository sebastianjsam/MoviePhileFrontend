import 'dart:convert';

import 'package:flutter_demo/src/utils/environment.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;

Future<bool> advertisingFinalService() async {
  String _tokenEndpoint = "/Advertising";
  String _url = _base + _tokenEndpoint;

  print("La url..............." + _url);
  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "dateIn": "2021-08-02T05:13:35.820Z",
      "dateOut": "2021-08-02T05:13:35.820Z",
      "filmId": 508943,
      "userId": "cf282ca3-4017-4778-9999-454faaf3cc15",
      "paymentId": 3
    }),
  );
  print("Adverstising");
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);

    if (jsonResponse >= 0) {
      return true;
    }
    print("Service: " + jsonResponse);
    return false;
  } else {
    return false;
  }
}
