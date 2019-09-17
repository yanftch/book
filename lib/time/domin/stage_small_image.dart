

class StageSmallImage {
  int imgId;
  String imgUrl;

  StageSmallImage({this.imgId, this.imgUrl});

  StageSmallImage.fromJson(Map<String, dynamic> json) {
    imgId = json['imgId'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgId'] = this.imgId;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}