import 'dart:io';

import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/Model/Genre.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class GenreService {
  // String url = 'https://10.0.2.2:5001​/api​/Genre';

  Future<List<Genre>> getAllGenre() async {
    // HttpOverrides.global = new MyHttpOverrides();
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += '/api/Genre';
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + TextApp.TOKEN_TEMPORAL
    });
    //print("entro al genero" + response.body);
    List<Genre> comunityList = [];
    if (response.statusCode == 200) {
      print("entro___ 1");

      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print("entro___ 2");
      addComunity(jsonData, comunityList);
      return comunityList;
    } else {
      print("Null primer llaamdo");
      return null;
    }
  }

  void addComunity(jsonData, List<Genre> comunityList) {
    for (var item in jsonData) {
      comunityList.add(Genre.fromJson(item));
      //  print("entro___ ingresad" + item.toString());
    }
  }
}
