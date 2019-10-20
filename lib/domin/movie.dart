import 'dart:collection';

import 'package:book/domins.dart';

class Movie {
  List<Actors> actorsStuffs;
  Actors director;
  int movieStatus;
  StageImg stageImg;
  String story;
  String releaseArea;
  int ratingCount;
  String mins;
  int hasSeenCount;
  String bigImage;
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
  String releaseDate;
  Video video;

  bool showRatings() => ratingFinal > 0;

  Movie(
      {this.actorsStuffs,
      this.director,
      this.movieStatus,
      this.stageImg,
      this.story,
      this.releaseArea,
      this.ratingCount,
      this.mins,
      this.hasSeenCount,
      this.bigImage,
      this.actorName1,
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
      this.releaseDate,
      this.video});

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['actors'] != null) {
      actorsStuffs = new List<Actors>();
      json['actors'].forEach((v) {
        actorsStuffs.add(new Actors.fromJson(v));
      });
    }
    if (json['director'] != null) {
      if (json['director'] is String) {
        director = Actors(name: json['director']);
      } else {
        director = new Actors.fromJson(json['director']);
      }
    } else {
      director = null;
    }

    movieStatus = json['movieStatus'];
    stageImg = json['stageImg'] != null
        ? new StageImg.fromJson(json['stageImg'])
        : null;
    story = json['story'];
    if (json['type'] is String) {
      type = json['type'];
    } else {
      List<dynamic> list = json['type'];
      var str = "";
      list.forEach((t) {
        str = "${t}/${str}";
      });
      if (str.endsWith("/")) {
        str = str.substring(0, str.length - 1);
      }
      type = str;
    }

    releaseArea = json['releaseArea'];

    ratingCount = json['ratingCount'];
    mins = json['mins'];
    hasSeenCount = json['hasSeenCount'];
    bigImage = json['bigImage'];
    actorName1 = json['actorName1'] ?? json['aN1'] ?? json['actor1'];
    actorName2 = json['actorName2'] ?? json['aN2'] ?? json['actor2'];
    btnText = json['btnText'];
    commonSpecial = json['commonSpecial'] ?? json['commentSpecial'];
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
    movieId = json['movieId'] ?? json['id'];
    nearestShowtime = json['nearestShowtime'] != null
        ? new NearestShowtime.fromJson(json['nearestShowtime'])
        : null;

    video = json['video'] != null ? new Video.fromJson(json['video']) : null;

    preferentialFlag = json['preferentialFlag'];
    rDay = json['rDay'];
    rMonth = json['rMonth'];
    rYear = json['rYear'];
    ratingFinal = (json['ratingFinal'] ?? json['r']) ?? json['overallRating'];
    titleCn = json['titleCn'] ?? json['title'] ?? json['t'] ?? json['name'];
    titleEn = json['titleEn'] ?? json['nameEn'];
    wantedCount = json['wantedCount'] ?? json['wantToSeeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actorsStuffs != null) {
      data['actors'] = this.actorsStuffs.map((v) => v.toJson()).toList();
    }
    if (this.director != null) {
      data['director'] = this.director.toJson();
    }
    data['movieStatus'] = this.movieStatus;
    if (this.stageImg != null) {
      data['stageImg'] = this.stageImg.toJson();
    }
    data['story'] = this.story;
    data['type'] = this.type;
    data['ratingCount'] = this.ratingCount;
    data['bigImage'] = this.bigImage;
    data['hasSeenCount'] = this.hasSeenCount;
    data['mins'] = this.mins;
    data['releaseArea'] = this.releaseArea;
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
    data['isIMAX3D'] = this.isIMAX3D;
    data['isNew'] = this.isNew;
    data['length'] = this.length;
    data['releaseDate'] = this.releaseDate;
    data['movieId'] = this.movieId;
    if (this.nearestShowtime != null) {
      data['nearestShowtime'] = this.nearestShowtime.toJson();
    }

    if (this.video != null) {
      data['video'] = this.video.toJson();
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
