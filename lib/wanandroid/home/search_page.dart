import 'package:flutter/material.dart';

/// 搜索列表页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: _buildBody(),
      );

      Widget  _buildBody() => Container(
        child: Wrap(children: <Widget>[
          Chip(label: Text("A"),),
            Chip(label: Text("BB"),),
            Chip(label: Text("ASD"),),
            Chip(label: Text("AFFDF"),),
            Chip(label: Text("BB"),),
            Chip(label: Text("ASD"),),
            Chip(label: Text("AFFDF"),),
            Chip(label: Text("ADFD"),),
            Chip(label: Text("ADFD"),),
            Chip(label: Text("ADGGG"),)
        ],),
      );
}
