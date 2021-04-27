import 'Comments.dart';
import 'Genre.dart';

class Film {
  int id;
  String title;
  String overView;
  String posterPath;
  Genre genre;
  List<Comments> comments;

  bool result;
  List<String> errors;

  Film(
      {this.id,
      this.title,
      this.overView,
      this.posterPath,
      this.genre,
      this.comments});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
        id: json['id'],
        title: json['title'],
        overView: json['overView'],
        posterPath: json['posterPath'],
        genre: json['genre'],
        comments: json['comments']);
  }
}
