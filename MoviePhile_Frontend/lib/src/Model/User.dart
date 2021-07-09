class User {
  String id;
  String userName;

  User({this.id, this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['token'],
      userName: json['token'],
    );
  }
}
