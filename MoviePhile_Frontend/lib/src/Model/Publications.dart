import 'package:flutter_demo/src/Model/User.dart';

import 'PublicationComment.dart';

class Publications {
  int id;
  String title;
  String content;
  String date;
  User user;
  List<PublicationComment> comments;

  Publications({this.id, this.title, this.content, this.date, this.user, this.comments});

  factory Publications.fromJson(Map<String, dynamic> json) {
    return Publications(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List).map((i) => PublicationComment.fromJson(i)).toList()
    );
  }

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "title": this.title,
    "content": this.content,
    "date": this.date,
    "user": this.user.toJson(),
    "comments": this.comments.map((c) => c.toJson())
  };
}
