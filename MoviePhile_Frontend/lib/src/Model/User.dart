class User {
  String id;
  String userName;
  String email;
  String password;

  User({this.id, this.userName, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": this.id, "userName": this.userName, "email": this.email, "password": this.password
  };
}
