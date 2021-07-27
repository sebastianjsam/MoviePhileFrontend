import 'dart:async';
import 'dart:convert';
import 'package:flutter_demo/src/Model/JsonAddUserToCommunity.dart';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;

Future<bool> serviceAddUserCommunity(int communityId) async {
  String _tokenEndpoint = "/Community/RegisterUser";
  String _url = _base + _tokenEndpoint;

  print("La url..............." + _url);
  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "communityId": communityId, //jsonUSERTOCOM.communityId,
      "UserId": "cf282ca3-4017-4778-9999-454faaf3cc15" //jsonUSERTOCOM.userId
    }),
  );
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    return false;
  }
}

Future<bool> serviceRemoveUserCommunity(int communityId) async {
  String _tokenEndpoint = "/Community/DeleteUser";
  String _url = _base + _tokenEndpoint;

  print("La url..............." + _url);
  final http.Response response = await http.delete(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "communityId": communityId, //jsonUSERTOCOM.communityId,
      "UserId": "cf282ca3-4017-4778-9999-454faaf3cc15" //jsonUSERTOCOM.userId
    }),
  );
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    return false;
  }
}

//status para saber si seguir o no
//"https://localhost:5001/api/Community/GetUserId?communityId=1&userId=cf282ca3-4017-4778-9999-454faaf3cc157"
Future<bool> serviceStatusUserCommunity(int communityId) async {
  String _tokenEndpoint = "/Community/GetUserId";
  String _url = _base + _tokenEndpoint;
  var token = await getStoredToken();
  var userID = parseJwt(token)['Id'];

  print("La url..............." +
      _url +
      '?' +
      'communityId=' +
      communityId.toString() +
      '&userId=' +
      userID);
  final http.Response response = await http.get(
      Uri.parse(_url +
          '?' +
          'communityId=' +
          communityId.toString() +
          '&userId=' +
          userID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  if (response.statusCode == 200) {
    print("respuesta:" + response.body);
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    return false;
  }
}
