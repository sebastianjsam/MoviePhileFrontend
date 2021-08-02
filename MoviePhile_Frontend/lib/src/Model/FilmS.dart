import 'dart:core';

import 'Comments.dart';
import 'Genre.dart';

class FilmS {
  int id;
  String title;
  String overView;
  String homePage;
  String posterPath;
  Genre genre;
  List<Comments> comments;
  double voteAverage;
  double popularity;
  double score;

  FilmS(
      {this.id,
      this.title,
      this.overView,
      this.homePage,
      this.posterPath,
      this.genre,
      this.comments,
      this.voteAverage,
      this.popularity,
      this.score});

  factory FilmS.fromJson(Map<String, dynamic> json) {
    print("Comments: " + json['comments'].toString());

    var commentsFromJson = json['comments'];
    List<Comments> commentsList = commentsFromJson.cast<Comments>();
    return FilmS(
        id: json['id'],
        title: json['title'],
        overView: json['overview'],
        homePage: 'https://image.tmdb.org/t/p/w500',
        posterPath: json['posterPath'],
        genre: Genre.fromJson(new Map<String, dynamic>.from(json['genre'])),
        comments: commentsList,
        voteAverage: json['voteAverage'],
        popularity: json['popularity'],
        score: json['score']);
    ;
  }

  List<Comments> addcomment(Map<String, dynamic> json) {
    List<Comments> list = [];
    for (int i = 0; i < json.length; i++) {
      print("json: " + json[i] + " numero: " + i.toString());
    }
    return list;
  }
}
