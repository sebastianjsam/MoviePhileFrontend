import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/src/Model/User.dart';
import 'package:flutter_demo/src/Model/User_Login.dart';
import 'package:flutter_demo/src/Model/token.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;
final _tokenEndpoint = "/auth/login";
final _url = _base + _tokenEndpoint;
String token;
Future<Token> getToken(UserLogin userLogin) async {
  print("La url..............." + _url);
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
    await saveToken(objectResponse.token);
    return objectResponse;
  } else {
    print((response.body).toString());
    return null;
    // throw Exception(json.decode(response.body));
  }
}

Future<Token> register(User user) async {
  final http.Response response = await http.post(
    Uri.parse(_base + '/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var objectResponse = Token.fromJson(jsonResponse);
    await saveToken(objectResponse.token);
    return objectResponse;
  } else {
    print((response.body).toString());
    return null;
    // throw Exception(json.decode(response.body));
  }
}

/// Guarda el token con el key (jwt) para utizarlo luego
Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', token);
}

/// Obtiene el token guardado
Future<String> getStoredToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

/// Permite obtener informaci??n de un token jwt
/// Se obtiene as??: valor = parseJwt(token)['valor']
/// Los valores que se pueden obtener son:
/// - ['Id']: es el id del usuario
/// - ['email']: es el email del usuario
Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

/// Decodifica el jwt
String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
