import 'dart:io';

import 'package:flutter_demo/src/Model/Film.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class searchTitle_service {
  String token =
      'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6ImE1MzI3MTMwLWQxYWYtNDFjYi1iNTFlLTQ4Y2ZhZTI3ZmUxYyIsInN1YiI6ImVzdGViYW5AZ21haWwuY29tIiwiZW1haWwiOiJlc3RlYmFuQGdtYWlsLmNvbSIsImp0aSI6IjUzODdkODEwLTc2YTAtNDMwYS04NmNlLTY0YjdkNWJkNmE5MiIsIm5iZiI6MTYyMDE2OTc5NywiZXhwIjoxNjIwMTkxMzk3LCJpYXQiOjE2MjAxNjk3OTd9.P02PLzS6AYn24pYpAvATqFu_10sU__3V62qJHsTAZpLjrLj6qbMiCgOdBpPxDAw11LxbaGK5wsJz3rXWK5ZeBg';
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
