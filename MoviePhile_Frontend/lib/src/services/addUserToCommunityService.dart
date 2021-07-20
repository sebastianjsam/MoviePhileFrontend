import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/src/Model/JsonAddUserToCommunity.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;
final _tokenEndpoint = "/api/Community/RegisterUser";
final _url = _base + _tokenEndpoint;

Future<bool> serviceAddUserCommunity(JsonerAddUserToCommunity jsonUSERTOCOM) async {
  print("La url..............." + _url);
  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(jsonUSERTOCOM.toJson()),
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    //var objectResponse = Token.fromJson(jsonResponse);
    print(jsonResponse);
    return true;
  } else {
    print((response.body).toString());
    return false;
    // throw Exception(json.decode(response.body));
  }
}