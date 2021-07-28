import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/src/Model/User.dart';
import 'package:flutter_demo/src/Model/Register_Promoted.dart';
import 'package:flutter_demo/src/Model/token.dart';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;
final _tokenEndpoint = "/Movies";
final _url = _base + _tokenEndpoint;

Future<bool> registerPromoted(RegisterPromoted register) async {
  /// String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
  print("La url..............." + _url);
  var token = await getStoredToken();
  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token
    },
    body: jsonEncode(register.toJson()),
  );
  print("response en titulo promosionado" + response.body);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body).toString();
    print("mira q salio " + jsonResponse);
    if (jsonResponse == "true") {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

/*
final _base = Environment.baseUrl;
String token;
Future<Token> registerPromoted(RegisterPromoted register) async {
  final http.Response response = await http.post(
    Uri.parse(_base + '/Movies'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(register.toJson()),
  );
  print("responde es " + response.body);

  if (response.statusCode == 200) {
    print("entro aqui..........");
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

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', token);
}

/// Obtiene el token guardado
Future<String> getStoredToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

/// Permite obtener información de un token jwt
/// Se obtiene así: valor = parseJwt(token)['valor']
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
*/
