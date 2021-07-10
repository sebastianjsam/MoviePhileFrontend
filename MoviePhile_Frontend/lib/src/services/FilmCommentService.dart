import 'dart:convert';
import 'package:flutter_demo/src/Model/FilmS.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;

class FilmcommentService {
  static Future<String> filmCommentSend(
      String comentario, String userID, int filmId, int commentType) async {
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += "/api/FilmComment";
    print("url: " + url);
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "content": comentario,
          "userId": userID,
          "filmId": filmId,
          "commentType": commentType
        }),
      );
    } catch (e) {
      throw ("filmCommentSend: Error Post, quizas Backend no disponible");
    }
    String user = response.body;
    print("user " + user);
    print("response.body " + response.body.toString());
    if (response.statusCode == 200) {
      return user.toString();
    } else {
      //throw ("filmCommentSend: Error leyendo datos del backend state!=200");
    }
  }

  static Future<FilmS> allCommentGetFilm(int filmId) async {
    var response;
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += "/api/Movies?movieId=" + filmId.toString();

    try {
      response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + TextApp.TOKEN_TEMPORAL
        },
      );
    } catch (e) {
      throw ("allCommentGetFilm: Error Get, quizas Backend no disponible");
    }

    var jsonResponse = json.decode(response.body);
    var objectResponse = FilmS.fromJson(jsonResponse);
    if (response.statusCode == 200) {
      return objectResponse;
    } else {
      print("Error: datos backend");
      throw ("allCommentGetFilm: Error leyendo datos del backend state!=200");
    }
  }

  /*static void Errores(var Errores) {
    var ErroresSeparados = Errores.split(',');
    String erroresPasword = "";
    String erroresEmail = "";
    for (var Es in ErroresSeparados) {
      if (Es.contains('Passwords')) {
        erroresPasword += Es + '\n';
      } else {
        erroresEmail += Es + '\n';
      }
    }
    if (erroresEmail != "") {
      TextApp.INVALID_EMAIL = erroresEmail;
      ValidateDatos.isEmailInvalid = true;
    }
    if (erroresPasword != "") {
      TextApp.INVALID_PASSWORD = erroresPasword;
      ValidateDatos.ispassWordInvalid = true;
    }
  }*/
}
