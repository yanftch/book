import 'package:book/domins.dart' show Movie;

class NowShowingMovieModel {
  String bImg;
  String date;
  bool hasPromo;
  List<Movie> ms;
  int lid;
  int newActivitiesTime;
  int totalComingMovie;
  String voucherMsg;

  NowShowingMovieModel(
      {this.bImg,
      this.date,
      this.hasPromo,
      this.ms,
      this.lid,
      this.newActivitiesTime,
      this.totalComingMovie,
      this.voucherMsg});

  NowShowingMovieModel.fromJson(Map<String, dynamic> json) {
    bImg = json['bImg'];
    date = json['date'];
    hasPromo = json['hasPromo'];
    lid = json['lid'];
    if(json['ms'] != null) {
      ms = new List<Movie>();
      json['ms'].forEach((v){
        ms.add(new Movie.fromJson(v));
      });
    }
    newActivitiesTime = json['newActivitiesTime'];
    totalComingMovie = json['totalComingMovie'];
    voucherMsg = json['voucherMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bImg'] = this.bImg;
    data['date'] = this.date;
    if(this.ms != null) {
      data['ms'] = this.ms.map((value) => value.toJson()).toList();
    }
    data['hasPromo'] = this.hasPromo;
    data['lid'] = this.lid;
    data['newActivitiesTime'] = this.newActivitiesTime;
    data['totalComingMovie'] = this.totalComingMovie;
    data['voucherMsg'] = this.voucherMsg;
    return data;
  }
}
