import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:book/domins.dart' show City, CityModel;

/// 读取本地 JSON 数据，选择城市列表
class SelectCityPage extends StatefulWidget {
  @override
  _SelectCityPageState createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  List<City> citys = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("选择城市"),
        ),
        body: citys.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _body());
  }

  Widget _body() => Container(
        child: ListView.separated(
            itemCount: citys.length,
            itemBuilder: _buildItem,
            separatorBuilder: (BuildContext context, int index) => Container(
                  height: 1,
                  color: Colors.grey[300],
                )),
      );

  Widget _buildItem(BuildContext context, int index) => GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Text(
            "${citys[index].name}",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        onTap: () {
          _itemClick(citys[index]);
        },
      );

  void _itemClick(City city) {
    print("click city:   $city");
    Navigator.pop(context, city);
  }

  void _getData() {
    Future<String> jsonString =
        DefaultAssetBundle.of(context).loadString('assets/city.json');
    jsonString.then((string) {
      dynamic d = json.decode(string);
      var cityModel = CityModel.fromJson(d);
      setState(() {
        citys.clear();
        citys.addAll(cityModel.citys);
      });
    });
  }
}
