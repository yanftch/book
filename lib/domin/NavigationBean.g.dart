// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NavigationBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationBean _$NavigationBeanFromJson(Map<String, dynamic> json) {
  return NavigationBean(
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : NaviBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NavigationBeanToJson(NavigationBean instance) =>
    <String, dynamic>{'data': instance.data};

NaviBean _$NaviBeanFromJson(Map<String, dynamic> json) {
  return NaviBean(
      cid: json['cid'] as int,
      name: json['name'] as String,
      articles: (json['articles'] as List)
          ?.map((e) => e == null
              ? null
              : ArticlesBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NaviBeanToJson(NaviBean instance) => <String, dynamic>{
      'cid': instance.cid,
      'name': instance.name,
      'articles': instance.articles
    };

ArticlesBean _$ArticlesBeanFromJson(Map<String, dynamic> json) {
  return ArticlesBean(
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
      zan: json['zan'] as int);
}

Map<String, dynamic> _$ArticlesBeanToJson(ArticlesBean instance) =>
    <String, dynamic>{
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
      'zan': instance.zan
    };
