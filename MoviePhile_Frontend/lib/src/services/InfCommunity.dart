import 'dart:convert';
import 'package:flutter_demo/src/Model/InfCommunity.dart';
import 'package:flutter_demo/src/Model/Comunity.dart';
import 'package:flutter_demo/src/services/user_service.dart';
import 'package:flutter_demo/src/utils/TextApp.dart';
import 'package:http/http.dart' as http;

class InfComunityService {
  static Future<InfComunity> GetInformationCommunityId(int idComunity) async {
    String url = TextApp.IP_BACKEND + TextApp.PORT_BACKEND;
    url += '/api/Community/InformationCommunity' +
        "?Idcommunity=" +
        idComunity.toString();
    var token = await getStoredToken();
    //HttpOverrides.global = new MyHttpOverrides();
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token
    });
    print("entro  response" + response.body);

    var body = json.decode(response.body);
    print("entro al comunidad " + body.toString());
    var jsonDato = InfComunity.fromJson(body);

    if (response.statusCode == 200) {
      return jsonDato;
    } else {
      print("Error: datos backend");
    }
  }
}
