import 'package:json_annotation/json_annotation.dart';

part 'HomeBannerBean.g.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs`
@JsonSerializable()
class HomeBannerBean {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  HomeBannerBean(
      {this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url});

  factory HomeBannerBean.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBannerBeanToJson(this);
}
