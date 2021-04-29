class Comments {
  int id;
  String content;
  int commentType;

  Comments({
    this.id,
    this.content,
    this.commentType,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      content: json['content'],
      commentType: json['commentType'],
    );
  }
}
