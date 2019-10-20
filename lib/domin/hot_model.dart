import 'package:book/domins.dart' show Movie;
class HotModel {
  int count;
  List<Movie> movies;
  int totalCinemaCount;
  int totalComingMovie;
  int totalHotMovie;

  HotModel(
      {this.count,
      this.movies,
      this.totalCinemaCount,
      this.totalComingMovie,
      this.totalHotMovie});

  HotModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['movies'] != null) {
      movies = new List<Movie>();
      json['movies'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
    totalCinemaCount = json['totalCinemaCount'];
    totalComingMovie = json['totalComingMovie'];
    totalHotMovie = json['totalHotMovie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    data['totalCinemaCount'] = this.totalCinemaCount;
    data['totalComingMovie'] = this.totalComingMovie;
    data['totalHotMovie'] = this.totalHotMovie;
    return data;
  }
}
