class RegisterPromoted {
  int idFilm;
  String titleFilm;
  String descriptionFilm;
  int idGenre;

  RegisterPromoted(
      {this.idFilm, this.titleFilm, this.descriptionFilm, this.idGenre});

  factory RegisterPromoted.fromJson(Map<String, dynamic> json) {
    return RegisterPromoted(
        idFilm: json['id'],
        titleFilm: json['title'],
        descriptionFilm: json['overview'],
        idGenre: json['genreId']);
  }

  Map<String, dynamic> toJson() => {
        "id": this.idFilm,
        "title": this.titleFilm,
        "overview": this.descriptionFilm,
        "genreId": this.idGenre
      };
}
