class HotKeyBean {
  List<HotKey> hotkeys;
  int errorCode;
  String errorMsg;

  HotKeyBean({this.hotkeys, this.errorCode, this.errorMsg});

  HotKeyBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      hotkeys = new List<HotKey>();
      json['data'].forEach((v) {
        hotkeys.add(new HotKey.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotkeys != null) {
      data['data'] = this.hotkeys.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class HotKey {
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotKey({this.id, this.link, this.name, this.order, this.visible});

  HotKey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}
