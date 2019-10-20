import 'package:book/domins.dart';

class StageImg {
  int count;
  List<StageSmallImage> list;

  StageImg({this.count, this.list});

  StageImg.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<StageSmallImage>();
      json['list'].forEach((v) { list.add(new StageSmallImage.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}