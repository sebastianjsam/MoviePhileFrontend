import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class consultarTitulo_service {
  Future<List<Film>> _listadoFilms;
  String token =
      'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImE1MzI3MTMwLWQxYWYtNDFjYi1iNTFlLTQ4Y2ZhZTI3ZmUxYyIsInN1YiI6ImVzdGViYW5AZ21haWwuY29tIiwiZW1haWwiOiJlc3RlYmFuQGdtYWlsLmNvbSIsImp0aSI6ImZkMWVkMzM5LWRmOTUtNGU4MS1iYzc1LTA2OWQyZWQwOTgyZCIsIm5iZiI6MTYxOTI5NjQ1OCwiZXhwIjoxNjE5MzE4MDU4LCJpYXQiOjE2MTkyOTY0NTh9.TOhG__ay2Z-I4oRSxSoMShClLcziF-vMkmuBUmubKpCbdQk_UQF_sE1Kn6H9Qe31GJV38aZTmjQzn7MhF7sHfw';
/**
   * Método que obtiene por medio de una petición get los datos de las películas y 
   * series alojados en el API de la plataforma TMDB ya que estos van a ser mostrados 
   * por medio de un Grid
 */
  String url = 'https://10.0.2.2:5001/api/Movies/popular';
  Future<List<Film>> getFilms() async {
    HttpOverrides.global = new MyHttpOverrides();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    List<Film> films = [];
    String path_img = 'https://image.tmdb.org/t/p/w500';
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      addFilm(jsonData, films, path_img);
      return films;
    } else {
      throw Exception("Falló la conexion");
    }
  }

  Future<List<Film>> getFilmsByName(String title) async {
    String url = 'https://10.0.2.2:5001/api/Movies/search?query=' + title;
    HttpOverrides.global = new MyHttpOverrides();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    List<Film> films = [];
    String path_img = 'https://image.tmdb.org/t/p/w500';
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      addFilm(jsonData, films, path_img);
      return films;
    } else {
      throw Exception("Falló la conexion");
    }
  }

  void addFilm(jsonData, List<Film> films, String path_img) {
    for (var item in jsonData["results"]) {
      films.add(Film(item["id"], item["original_title"],
          '$path_img' '${item["poster_path"]}', item["overview"]));
    }
  }
}