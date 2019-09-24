enum CollectionType { GANK, STYUDY, TIME }

class DbModel {
  int id;
  String url;
  String title;
  String type; /// study, gank, time

  /// 标记是  电影，玩安卓，还是 gank
  int movieId;

  DbModel({this.id, this.url, this.title, this.type, this.movieId});

  DbModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    type = json['type'];
    movieId = json['movie_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['type'] = this.type;
    data['movie_id'] = this.movieId;
    return data;
  }

  @override
  String toString() {
    return 'DbModel{id: $id, url: $url, title: $title, type: $type, movieId: $movieId}';
  }
}
