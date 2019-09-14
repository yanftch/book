import 'package:flutter/material.dart';


/// 项目 列表页
///
class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  void initState() {
    super.initState();
    Future<String> loadString = DefaultAssetBundle.of(context).loadString(
        "assets/city.json");


    loadString.then((String value) {
      // 通知框架此对象的内部状态已更改
//      print("value--->$value");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project"),
        centerTitle: true,
//        bottom: _buildBottom(),
      ),
      body: Center(
        child: Text("2"),
      ),
    );
  }

  // 导航栏 底部 TAB
  PreferredSizeWidget _buildBottom() => null;


}