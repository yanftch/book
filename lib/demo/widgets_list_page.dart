import 'dart:math';

import 'package:flutter/material.dart';

/// 每周一组件 列表入口
///
class WidgetsListPage extends StatefulWidget {
  @override
  _WidgetsListPageState createState() => new _WidgetsListPageState();
}

/// state for [WidgetsListPage]
class _WidgetsListPageState extends State<WidgetsListPage> {
  Color randomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget for week"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => Column(
        children: <Widget>[
          InkWell(
            child: ListTile(
              title: Text("Text"),
              trailing: Icon(Icons.text_fields, color: randomColor()),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/widgets_for_text");
            },
          ),
          InkWell(
            child: ListTile(
              title: Text("Button"),
              trailing: Icon(Icons.radio_button_checked, color: randomColor()),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/widgets_for_button");
            },
          ),
          InkWell(
            child: ListTile(
              title: Text("WebView 与 JS 交互"),
              trailing: Icon(Icons.web, color: randomColor()),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/widgets_for_week_webview");
            },
          ),
           InkWell(
            child: ListTile(
              title: Text("WebView 与 JS 交互"),
              trailing: Icon(Icons.web, color: randomColor()),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/widgets_for_week_webview");
            },
          )
        ],
      );
}
