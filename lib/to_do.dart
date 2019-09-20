import 'package:flutter/material.dart';

/// 使用到的三方库
/// banner : https://github.com/best-flutter/flutter_swiper
///
class TodoListPage extends StatelessWidget {
  final todoList = <Todo>[
    Todo(false, "1.title 和 subtitle 的 Text，样式各自统一的话，可以考虑分别封装不同的 Text，自带样式。"),
    Todo(false, "2.影片简介页面，story 内容，展开/收起  功能完善"),
    Todo(false, "3.image 加载过程中的 loadingbuilder 添加默认图"),
    Todo(false, "首页小的 icon 添加随机颜色"),
    Todo(false, "大图页面，支持本地保存图片"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Something to do"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => ListView.separated(
      itemBuilder: _buildItem,
      separatorBuilder: _buildSeparator,
      itemCount: todoList.length);

  Widget _buildItem(BuildContext context, int index) => ListTile(
        title: Text(
          todoList[index].title,
          style: TextStyle(
              decoration: todoList[index].finished
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: Colors.red),
        ),
      );

  Widget _buildSeparator(BuildContext context, int index) => Container(
        height: 1,
        color: Colors.black12,
      );
}

class Todo {
  var finished = false;
  var title;

  Todo(this.finished, this.title);
}
