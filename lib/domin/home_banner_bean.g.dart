// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_banner_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBannerBean _$HomeBannerBeanFromJson(Map<String, dynamic> json) {
  return HomeBannerBean(
    desc: json['desc'] as String,
    id: json['id'] as int,
    imagePath: json['imagePath'] as String,
    isVisible: json['isVisible'] as int,
    order: json['order'] as int,
    title: json['title'] as String,
    type: json['type'] as int,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$HomeBannerBeanToJson(HomeBannerBean instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'imagePath': instance.imagePath,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
    };
