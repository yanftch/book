

class BoxOffice {
  int movieId;
  int ranking;
  int todayBox;
  String todayBoxDes;
  String todayBoxDesUnit;
  int totalBox;
  String totalBoxDes;
  String totalBoxUnit;

  BoxOffice({this.movieId, this.ranking, this.todayBox, this.todayBoxDes, this.todayBoxDesUnit, this.totalBox, this.totalBoxDes, this.totalBoxUnit});

  BoxOffice.fromJson(Map<String, dynamic> json) {
    movieId = json['movieId'];
    ranking = json['ranking'];
    todayBox = json['todayBox'];
    todayBoxDes = json['todayBoxDes'];
    todayBoxDesUnit = json['todayBoxDesUnit'];
    totalBox = json['totalBox'];
    totalBoxDes = json['totalBoxDes'];
    totalBoxUnit = json['totalBoxUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movieId'] = this.movieId;
    data['ranking'] = this.ranking;
    data['todayBox'] = this.todayBox;
    data['todayBoxDes'] = this.todayBoxDes;
    data['todayBoxDesUnit'] = this.todayBoxDesUnit;
    data['totalBox'] = this.totalBox;
    data['totalBoxDes'] = this.totalBoxDes;
    data['totalBoxUnit'] = this.totalBoxUnit;
    return data;
  }
}