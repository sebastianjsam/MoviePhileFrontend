import 'dart:io';

import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/Model/Film.dart';
import 'package:flutter_demo/src/Model/Genre.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../main.dart';

class GenreService {
  String url = 'https://10.0.2.2:5001​/api​/Genre';

  Future<List<Genre>> getAllGenre() async {
    // HttpOverrides.global = new MyHttpOverrides();
    final response = await http.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ' + TextApp.TOKEN_TEMPORAL});
    print("responde de genero" + response.body);
    List<Genre> genreList = new List();
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var data in jsonData) {
        Genre genre = Genre.fromJson(data);
        genreList.add(genre);
      }

      return genreList;
    } else {
      print("Null primer llaamdo");
      return null;
    }
  }
}
