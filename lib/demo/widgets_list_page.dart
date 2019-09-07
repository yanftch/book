import 'package:flutter/material.dart';

/// 每周一组件 列表入口
///
class WidgetsListPage extends StatefulWidget {
  @override
  _WidgetsListPageState createState() => new _WidgetsListPageState();
}

/// state for [WidgetsListPage]
class _WidgetsListPageState extends State<WidgetsListPage> {
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
          GestureDetector(
            child: ListTile(
              title: Text("Text"),
              trailing: Icon(Icons.text_fields),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/widgets_for_text");

            },
          )
        ],
      );
}
