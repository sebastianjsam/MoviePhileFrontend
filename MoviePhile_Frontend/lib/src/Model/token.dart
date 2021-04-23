class Token {
  String token;
  bool result;
  List<String> errors;

  Token({this.token, this.result, this.errors});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token'], result: json['result'], errors: json['errors']);
  }
}
