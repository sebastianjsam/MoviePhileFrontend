import 'dart:convert';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PostInCommunityService {
  static Future<String> postInCommunitySend(
      String content, String title, int communitytId) async {
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += "/api/Publication";
    print("url: " + url);
    var response;
    //var token = await getStoredToken();
    var token = TextApp.TOKEN_TEMPORAL;
    var userID = parseJwt(token)['Id'];

    var now = new DateTime.now();
    var formatter = new DateFormat("yyyy-MM-ddTHH:m:ss");
    //var formatter = new DateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(now);
    print("date: " + formattedDate);

    print(now);
    try {
      response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "id": 0,
          "title": title,
          "content": content,
          "date": formattedDate,
          "userId": userID,
          "communityId": communitytId
        }),
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
      return res.toString();
    } else {
      throw ("postInCommunitySend: Error leyendo datos del backend state!=200");
    }
  }
}
