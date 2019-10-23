import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build
part 'navigation_bean.g.dart';

@JsonSerializable()
class NavigationBean {
  List<NaviBean> data = new List();

  NavigationBean({this.data});

  factory NavigationBean.fromJson(List<dynamic> parsedJson) {
    List<NaviBean> photos = new List<NaviBean>();
    photos = parsedJson.map((i) => NaviBean.fromJson(i)).toList();
    return new NavigationBean(
      data: photos,
    );
  }
}

@JsonSerializable()
class NaviBean {
  int cid;
  String name;
  List<ArticlesBean> articles;

  NaviBean({this.cid, this.name, this.articles});

  @override
  String toString() {
    return 'NaviBean{cid: $cid, name: $name, articles: $articles}';
  }

  //序列化
  factory NaviBean.fromJson(Map<String, dynamic> json) =>
      _$NaviBeanFromJson(json);

  //反序列化
  Map<String, dynamic> toJson() => _$NaviBeanToJson(this);
}

@JsonSerializable()
class ArticlesBean {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  //序列化
  factory ArticlesBean.fromJson(Map<String, dynamic> json) =>
      _$ArticlesBeanFromJson(json);

  //反序列化
  Map<String, dynamic> toJson() => _$ArticlesBeanToJson(this);

  ArticlesBean(
      {this.apkLink,
      this.author,
      this.chapterId,
      this.chapterName,
      this.collect,
      this.courseId,
      this.desc,
      this.envelopePic,
      this.fresh,
      this.id,
      this.link,
      this.niceDate,
      this.origin,
      this.projectLink,
      this.publishTime,
      this.superChapterId,
      this.superChapterName,
      this.title,
      this.type,
      this.userId,
      this.visible,
      this.zan});
}
