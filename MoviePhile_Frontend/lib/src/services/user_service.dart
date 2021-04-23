import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/src/Model/token.dart';
import 'package:flutter_demo/src/pages/LoginUsuario_page.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package: http/http.dart' as http;

final _base = Environment.baseUrl;
final _tokenEndpoint = "/auth/login";
final _url = _base + _tokenEndpoint;

Future<Token> getToken(LoginUsuarioPage userLogin) async {
  print(_url);
  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toJson()),
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var objectResponse = Token.fromJson(jsonResponse);
    print(jsonResponse);
    return objectResponse;
  } else {
    print((response.body).toString());
    return null;
    // throw Exception(json.decode(response.body));
  }
}
