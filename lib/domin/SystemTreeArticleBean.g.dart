// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SystemTreeArticleBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemTreeArticleBean _$SystemTreeArticleBeanFromJson(
    Map<String, dynamic> json) {
  return SystemTreeArticleBean(
    curPage: json['curPage'] as int,
    offset: json['offset'] as int,
    over: json['over'] as bool,
    pageCount: json['pageCount'] as int,
    size: json['size'] as int,
    total: json['total'] as int,
    datas: (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : DatasBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SystemTreeArticleBeanToJson(
        SystemTreeArticleBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
      'datas': instance.datas,
    };

DatasBean _$DatasBeanFromJson(Map<String, dynamic> json) {
  return DatasBean(
    apkLink: json['apkLink'] as String,
    author: json['author'] as String,
    chapterId: json['chapterId'] as int,
    chapterName: json['chapterName'] as String,
    collect: json['collect'] as bool,
    courseId: json['courseId'] as int,
    desc: json['desc'] as String,
    envelopePic: json['envelopePic'] as String,
    fresh: json['fresh'] as bool,
    id: json['id'] as int,
    link: json['link'] as String,
    niceDate: json['niceDate'] as String,
    origin: json['origin'] as String,
    projectLink: json['projectLink'] as String,
    publishTime: json['publishTime'] as int,
    superChapterId: json['superChapterId'] as int,
    superChapterName: json['superChapterName'] as String,
    title: json['title'] as String,
    type: json['type'] as int,
    userId: json['userId'] as int,
    visible: json['visible'] as int,
    zan: json['zan'] as int,
  );
}

Map<String, dynamic> _$DatasBeanToJson(DatasBean instance) => <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
