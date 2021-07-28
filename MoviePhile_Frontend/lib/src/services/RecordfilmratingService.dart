import 'dart:convert';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;

class RecordfilmratingService {
  static Future<bool> Recordfilmrating2(int value, int filmId) async {
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += "/api/Score";
    print("url: " + url);
    print("FilmId: " + filmId.toString());
    var response;
    //var token = await getStoredToken();
    var token = TextApp.TOKEN_TEMPORAL;
    var userID = parseJwt(token)['Id'];

    try {
      response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"value": value, "filmId": filmId, "userId": userID}),
      );
    } catch (e) {
      print(response);
      throw ("filmCommentSend: Error Post, quizas Backend no disponible" +
          response);
    }
    String res = response.body;
    print("respuesta del backen: " + res);
    print("response.body " + response.body.toString());
    if (response.statusCode == 200) {
      return res.contains('true');
    } else {
      //throw ("postInCommunitySend: Error leyendo datos del backend state!=200");
      return !res.contains('false');
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
