import 'User.dart';

class PublicationComment {
  int id;
  String content;
  String date;
  User user;

  PublicationComment({
    this.id,
    this.content,
    this.date,
    this.user
  });

  factory PublicationComment.fromJson(Map<String, dynamic> json) {
    return PublicationComment(
      id: json['id'],
      content: json['content'],
      date: json['date'],
      user: User.fromJson(json['user'])
    );
  }

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "content": this.content,
    "date": this.date,
    "user": this.user.toJson()
  };
}
