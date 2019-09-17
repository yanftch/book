import 'package:book/domins.dart' show Video;

class TricksModel {
  int totalPageCount;
  int totalCount;
  List<Video> videos;

  TricksModel({this.totalPageCount, this.totalCount, this.videos});

  TricksModel.fromJson(Map<String, dynamic> json) {
    totalPageCount = json['totalPageCount'];
    totalCount = json['totalCount'];
    if (json['videoList'] != null) {
      videos = new List<Video>();
      json['videoList'].forEach((v) {
        videos.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPageCount'] = this.totalPageCount;
    data['totalCount'] = this.totalCount;
    if (this.videos != null) {
      data['videoList'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
