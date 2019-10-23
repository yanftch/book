import 'package:json_annotation/json_annotation.dart';

part 'system_tree_bean.g.dart';

//flutter packages pub run build_runner build
@JsonSerializable()
class SystemTreeBean {
  List<DataBean> data = new List();

  SystemTreeBean({this.data});

  factory SystemTreeBean.fromJson(List<dynamic> parsedJson) {

    List<DataBean> photos = new List<DataBean>();
    photos = parsedJson.map((i)=>DataBean.fromJson(i)).toList();
    return new SystemTreeBean(
      data: photos,
    );
  }

//反序列化
//  factory SystemTreeBean.fromJson(List<dynamic> json) =>
//      _$SystemTreeBeanFromJson(json.map((i)=>DataBean.fromJson(i)).toList());

//序列化
  Map<String, dynamic> toJson() => _$SystemTreeBeanToJson(this);
}

@JsonSerializable()
class DataBean {


  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
  List<DataBean> children = new List();

  DataBean(
      {this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible,
      this.children});

//反序列化
  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

//序列化
  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}
