import 'package:book/domins.dart' show NearestShowtime, Video;

class Movie {
  String actorName1;
  String actorName2;
  String btnText;
  String commonSpecial;
  String directorName;
  String img;
  bool is3D;
  bool isDMAX;
  bool isFilter;
  bool isHot;
  bool isIMAX;
  bool isIMAX3D;
  bool isNew;
  int length;
  int movieId;
  NearestShowtime nearestShowtime;
  bool preferentialFlag;
  int rDay;
  int rMonth;
  int rYear;
  num ratingFinal;
  String titleCn;
  String titleEn;
  String type;
  int wantedCount;
  String actors;
  String releaseDate;
  List<Video> videos;

  bool showRatings() => ratingFinal > 0;

  Movie(
      {this.actorName1,
      this.actorName2,
      this.btnText,
      this.commonSpecial,
      this.directorName,
      this.img,
      this.is3D,
      this.isDMAX,
      this.isFilter,
      this.isHot,
      this.isIMAX,
      this.isIMAX3D,
      this.isNew,
      this.length,
      this.movieId,
      this.nearestShowtime,
      this.preferentialFlag,
      this.rDay,
      this.rMonth,
      this.rYear,
      this.ratingFinal,
      this.titleCn,
      this.titleEn,
      this.type,
      this.wantedCount,
      this.actors,
      this.releaseDate,
        this.videos});

  Movie.fromJson(Map<String, dynamic> json) {
    actorName1 = json['actorName1'] ?? json['aN1'] ?? json['actor1'];
    actorName2 = json['actorName2'] ?? json['aN2'] ?? json['actor2'];
    actors = json['actors'];
    btnText = json['btnText'];
    commonSpecial = json['commonSpecial'];
    directorName = json['directorName'];
    img = json['img'] ?? json['image'];
    is3D = json['is3D'];
    isDMAX = json['isDMAX'];
    isFilter = json['isFilter'];
    isHot = json['isHot'];
    isIMAX = json['isIMAX'];
    isIMAX3D = json['isIMAX3D'];
    isNew = json['isNew'];
    length = json['length'];
    releaseDate = json['releaseDate'];
    movieId = json['movieId'];
    nearestShowtime = json['nearestShowtime'] != null
        ? new NearestShowtime.fromJson(json['nearestShowtime'])
        : null;
    if (json['videos'] != null) {
      videos = List<Video>();
      json['videos'].forEach((v) {
        videos.add(Video.fromJson(v));
      });
    }

    preferentialFlag = json['preferentialFlag'];
    rDay = json['rDay'];
    rMonth = json['rMonth'];
    rYear = json['rYear'];
    ratingFinal = json['ratingFinal'] ?? json['r'];
    titleCn = json['titleCn'] ?? json['title'] ?? json['t'];
    titleEn = json['titleEn'];
    type = json['type'];
    wantedCount = json['wantedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actorName1'] = this.actorName1;
    data['actorName2'] = this.actorName2;
    data['btnText'] = this.btnText;
    data['commonSpecial'] = this.commonSpecial;
    data['directorName'] = this.directorName;
    data['img'] = this.img;
    data['is3D'] = this.is3D;
    data['isDMAX'] = this.isDMAX;
    data['isFilter'] = this.isFilter;
    data['isHot'] = this.isHot;
    data['isIMAX'] = this.isIMAX;
    data['actors'] = this.actors;
    data['isIMAX3D'] = this.isIMAX3D;
    data['isNew'] = this.isNew;
    data['length'] = this.length;
    data['releaseDate'] = this.releaseDate;
    data['movieId'] = this.movieId;
    if (this.nearestShowtime != null) {
      data['nearestShowtime'] = this.nearestShowtime.toJson();
    }

    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['preferentialFlag'] = this.preferentialFlag;
    data['rDay'] = this.rDay;
    data['rMonth'] = this.rMonth;
    data['rYear'] = this.rYear;
    data['ratingFinal'] = this.ratingFinal;
    data['titleCn'] = this.titleCn;
    data['titleEn'] = this.titleEn;
    data['type'] = this.type;
    data['wantedCount'] = this.wantedCount;
    return data;
  }
}
