import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/utils/environment.dart';
import 'package:http/http.dart' as http;

final _base = Environment.baseUrl;
final _tokenEndpoint = "/Community/RegisterCommunity";
final _url = _base + _tokenEndpoint;


Future<bool> POSTRegistrarComunidad(Comunity comunity) async {
  print("Locooooo La url..............." + _url);

  final http.Response response = await http.post(
    Uri.parse(_url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(comunity.toJson()),
  );

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body).toString();

    if (jsonResponse == "true"){
      return true;
    }
    else{
      return false;
    }
  } else {
    return false;
  }

}

