import 'dart:convert';

import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;

class filmcommentService {
  static String url = TextApp.IP_BACKEND +
      TextApp.PORT_BACKEND +
      "/api/FilmCommentControllerBase/CommentFilm";
  //
  static Future<String> registerUser(
      String comentario, String userID, int filmId, int commentType) async {
    var response;
    print("tipo de comentario: " + commentType.toString());

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
      print("Error: Post");
    }
    String user = response.body;
    if (response.statusCode == 200) {
      user = response.body;
      return user;
    } else {
      user = response.body;
      return user;
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
