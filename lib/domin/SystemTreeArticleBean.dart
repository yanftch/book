import 'package:json_annotation/json_annotation.dart';

part 'SystemTreeArticleBean.g.dart';

//flutter packages pub run build_runner build
@JsonSerializable()
class SystemTreeArticleBean {
  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<DatasBean> datas;

  SystemTreeArticleBean(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  @override
  String toString() {
    return 'SystemTreeArticleBean{curPage: $curPage, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total, datas: $datas}';
  }

  //序列化
  factory SystemTreeArticleBean.fromJson(Map<String, dynamic> json) =>
      _$SystemTreeArticleBeanFromJson(json);

  //反序列化
  Map<String, dynamic> toJson() => _$SystemTreeArticleBeanToJson(this);
}

@JsonSerializable()
class DatasBean {
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

  DatasBean(
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

//序列化
  factory DatasBean.fromJson(Map<String, dynamic> json) =>
      _$DatasBeanFromJson(json);

  //反序列化
  Map<String, dynamic> toJson() => _$DatasBeanToJson(this);
}
