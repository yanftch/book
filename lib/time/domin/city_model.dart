class CityModel {
  List<City> citys;

  CityModel({this.citys});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['p'] != null) {
      citys = new List<City>();
      json['p'].forEach((v) {
        citys.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.citys != null) {
      data['p'] = this.citys.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int count;
  int id;
  String name;
  String pinyinFull;
  String pinyinShort;

  City({this.count, this.id, this.name, this.pinyinFull, this.pinyinShort});

  City.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    id = json['id'];
    name = json['n'];
    pinyinFull = json['pinyinFull'];
    pinyinShort = json['pinyinShort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['id'] = this.id;
    data['n'] = this.name;
    data['pinyinFull'] = this.pinyinFull;
    data['pinyinShort'] = this.pinyinShort;
    return data;
  }

  String toString() => "City: count=$count, id=$id, name=$name";
}
