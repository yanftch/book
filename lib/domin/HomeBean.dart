import 'package:json_annotation/json_annotation.dart';

part 'HomeBean.g.dart';

@JsonSerializable()
class HomeBean {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<HomeItemBean> datas = new List();

  HomeBean(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  //反序列化
  factory HomeBean.fromJson(Map<String, dynamic> json) =>
      _$HomeBeanFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$HomeBeanToJson(this);

  @override
  String toString() {
    return 'HomeBean{curPage: $curPage, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total, datas: $datas}';
  }
}

@JsonSerializable()
class HomeItemBean {
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
  List<TagsBean> tags;

  //反序列化
  factory HomeItemBean.fromJson(Map<String, dynamic> json) =>
      _$HomeItemBeanFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$HomeItemBeanToJson(this);

  HomeItemBean(
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
      this.zan,
      this.tags});
}

@JsonSerializable()
class TagsBean {
  String name;
  String url;

  TagsBean({this.name, this.url});

  //反序列化
  factory TagsBean.fromJson(Map<String, dynamic> json) =>
      _$TagsBeanFromJson(json);

  //序列化
  Map<String, dynamic> toJson() => _$TagsBeanToJson(this);
}
