class Video {
  String hightUrl;
  String image;
  int length;
  String title;
  String url;
  int videoId;

  Video(
      {this.hightUrl,
        this.image,
        this.length,
        this.title,
        this.url,
        this.videoId});

  Video.fromJson(Map<String, dynamic> json) {
    hightUrl = json['hightUrl'];
    image = json['image'];
    length = json['length'];
    title = json['title'];
    url = json['url'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hightUrl'] = this.hightUrl;
    data['image'] = this.image;
    data['length'] = this.length;
    data['title'] = this.title;
    data['url'] = this.url;
    data['videoId'] = this.videoId;
    return data;
  }
}