import 'package:book/domins.dart';

class ComingMovies {
  List<Movie> attention;
  List<Movie> moviecomings;

  ComingMovies({this.attention, this.moviecomings});

  ComingMovies.fromJson(Map<String, dynamic> json) {
    if (json['attention'] != null) {
      attention = List<Movie>();
      json['attention'].forEach((v) {
        attention.add(Movie.fromJson(v));
      });
    }
    if (json['moviecomings'] != null) {
      moviecomings = List<Movie>();
      json['moviecomings'].forEach((v) {
        moviecomings.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.attention != null) {
      data['attention'] = this.attention.map((v) => v.toJson()).toList();
    }


    if (this.moviecomings != null) {
      data['moviecomings'] = this.moviecomings.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
