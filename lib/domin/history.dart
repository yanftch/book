class History {
  String eId;
  String title;
  String content;
  String picNo;
  List<PicUrl> picUrl;
  
  History({this.eId, this.title, this.content, this.picNo, this.picUrl});

  History.fromJson(Map<String, dynamic> json) {
    eId = json['e_id'];
    title = json['title'];
    content = json['content'];
    picNo = json['picNo'];
    if (json['picUrl'] != null) {
      picUrl = new List<PicUrl>();
      json['picUrl'].forEach((v) {
        picUrl.add(new PicUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['e_id'] = this.eId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['picNo'] = this.picNo;
    if (this.picUrl != null) {
      data['picUrl'] = this.picUrl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PicUrl {
  String picTitle;
  int id;
  String url;

  PicUrl({this.picTitle, this.id, this.url});

  PicUrl.fromJson(Map<String, dynamic> json) {
    picTitle = json['pic_title'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pic_title'] = this.picTitle;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
