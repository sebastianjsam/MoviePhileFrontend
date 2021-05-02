import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class ConsultComunityService {
  Future<List<Film>> _listadoFilms;
  String url = 'https://10.0.2.2:5001/api/Community';

  /**
   * Método que obtiene por medio de una petición get los datos de las películas y 
   * series alojados en el API de la plataforma TMDB ya que estos van a ser mostrados 
   * por medio de un Grid
 */

  Future<List<Comunity>> getAllComunity() async {
    HttpOverrides.global = new MyHttpOverrides();
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ' + TextApp.TOKEN_TEMPORAL});
    List<Comunity> comunityList = [];

    String path_img = 'https://image.tmdb.org/t/p/w500';

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      addComunity(jsonData, comunityList, path_img);
      return comunityList;
    } else {
      throw Exception("Falló la conexion");
    }
  }

  Future<List<Comunity>> getComunityByName(String title) async {
    String url = 'https://10.0.2.2:5001/api/Community/stranger things' + title;
    HttpOverrides.global = new MyHttpOverrides();
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ' + TextApp.TOKEN_TEMPORAL});
    List<Comunity> comunityList = [];
    String path_img = 'https://image.tmdb.org/t/p/w500';
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(jsonData);
      comunityList.add(Comunity.fromJson(jsonData));
      return comunityList;
    } else {
      throw Exception("Falló la conexion");
    }
  }

  void addComunity(jsonData, List<Comunity> comunityList, String path_img) {
    for (var item in jsonData) {
      comunityList.add(Comunity.fromJson(item));
    }
  }
}