

/// 演员&导演&工作人员  数据类

class Actors {
  int actorId;
  String img;
  String name;
  String nameEn;
  String roleImg;
  String roleName;
  String roleNameEn;

  Actors({this.actorId, this.img, this.name, this.nameEn, this.roleImg, this.roleName});

  Actors.fromJson(Map<String, dynamic> json) {

    actorId = json['actorId'] ?? json['id'] ?? json['directorId'];
    img = json['img'] ?? json['image'];
    name = json['name'];
    nameEn = json['nameEn'];
    roleImg = json['roleImg'];
    roleName = json['roleName'] ?? json['personateCn'];
    roleNameEn = json['personateEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actorId'] = this.actorId;
    data['img'] = this.img;
    data['name'] = this.name;
    data['nameEn'] = this.nameEn;
    data['roleImg'] = this.roleImg;
    data['roleName'] = this.roleName;
    data['roleNameEn'] = this.roleNameEn;
    return data;
  }
}