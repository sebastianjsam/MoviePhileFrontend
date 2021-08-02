class Genre {
  int id;
  String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
  static List<Genre> getListGenre(jsonData) {
    List<Genre> genreList2 = [];
    for (var item in jsonData["genres"]) {
      genreList2.add(Genre(id: item['id'], name: item["Name"]));
    }
    return genreList2;
  }
}
