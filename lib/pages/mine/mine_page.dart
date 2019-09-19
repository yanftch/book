import 'package:flutter/material.dart';
import 'package:book/domins.dart';
import 'package:book/http.dart' show HttpGankUtils;

///
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mine"),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          child: Text("click==$total"),
          onPressed: () {
            getRandomData();
          },
        ),
      ),
    );
  }

  /// 获取 IOS 列表数据
  void getRandomData() async {
    GankCategory category = await HttpGankUtils.getIOSDatas(0);
    print("gank--->${category.results.length}");
    setState(() {
      total = category.results.length;
    });
  }
}
