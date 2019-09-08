import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  final todoList = <Todo>[
    Todo(false, "1.title 和 subtitle 的 Text，样式各自统一的话，可以考虑分别封装不同的 Text，自带样式。"),
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
