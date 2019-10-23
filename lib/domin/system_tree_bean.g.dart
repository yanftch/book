// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_tree_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemTreeBean _$SystemTreeBeanFromJson(Map<String, dynamic> json) {
  return SystemTreeBean(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : DataBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SystemTreeBeanToJson(SystemTreeBean instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DataBean _$DataBeanFromJson(Map<String, dynamic> json) {
  return DataBean(
    courseId: json['courseId'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    order: json['order'] as int,
    parentChapterId: json['parentChapterId'] as int,
    userControlSetTop: json['userControlSetTop'] as bool,
    visible: json['visible'] as int,
    children: (json['children'] as List)
        ?.map((e) =>
            e == null ? null : DataBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataBeanToJson(DataBean instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
      'children': instance.children,
    };
