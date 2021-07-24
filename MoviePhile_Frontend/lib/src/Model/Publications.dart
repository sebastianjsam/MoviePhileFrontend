class Publications {
  int id;
  String title;
  String content;

  Publications({this.id, this.title, this.content});

  factory Publications.fromJson(Map<String, dynamic> json) {
    return Publications(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": this.id, "title": this.title, "content": this.content};
}
