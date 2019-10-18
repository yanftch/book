class GankCategory {
  bool error;
  List<GankInfo> results;

  GankCategory({this.error, this.results});

  factory GankCategory.fromJson(Map<String, dynamic> json) {
    return GankCategory(
      error: json['error'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => GankInfo.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GankInfo {
  String id;
  String createdAt;
  String desc;
  List<String> images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  String imgUrl() => (images == null || images.isEmpty) ? "" : images[0];
  String showTime() => publishedAt.substring(0, 10);

  GankInfo(
      {this.id,
      this.createdAt,
      this.desc,
      this.images,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who});

  factory GankInfo.fromJson(Map<String, dynamic> json) {
    return GankInfo(
      id: json['_id'],
      createdAt: json['createdAt'],
      desc: json['desc'],
      images:
          json['images'] != null ? new List<String>.from(json['images']) : null,
      publishedAt: json['publishedAt'],
      source: json['source'],
      type: json['type'],
      url: json['url'],
      used: json['used'],
      who: json['who'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['publishedAt'] = this.publishedAt;
    data['source'] = this.source;
    data['type'] = this.type;
    data['url'] = this.url;
    data['used'] = this.used;
    data['who'] = this.who;
    if (this.images != null) {
      data['images'] = this.images;
    }
    return data;
  }
}
