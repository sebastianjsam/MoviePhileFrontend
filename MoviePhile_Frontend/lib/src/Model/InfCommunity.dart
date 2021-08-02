import 'package:flutter_demo/src/Model/User.dart';
import 'package:flutter_demo/src/Model/Publications.dart';

class InfComunity {
  int id;
  String name;
  String description;
  String genres;
  List<Publications> publications; //lista de publicaciones de la comunidad
  List<User> users; //lista de usuarios que estan en la comunidad

  InfComunity({
    this.id,
    this.name,
    this.description,
    this.genres,
    this.publications, //lista de publicaciones de la comunidad
    this.users,
  });

  factory InfComunity.fromJson(Map<String, dynamic> json) {
    return InfComunity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      genres: json['genres'],
      publications: getListPublications(json),
      users: getListUser(json)
    );
  }
  static List<User> getListUser(jsonData) {
    List<User> usersList2 = [];
    var name;
    for (var item in jsonData["users"]) {
      usersList2.add(User.fromJson(item));
    }
    return usersList2;
  }

  static List<Publications> getListPublications(jsonData) {
    List<Publications> publicationList = [];
    for (var item in jsonData["publications"]) {
      publicationList.add(Publications.fromJson(item));
    }

    return publicationList;
  }
}
