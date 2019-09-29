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
    Todo(false, "收藏列表支持长按&侧滑删除"),
    Todo(false, "gank 首页顶部的 grid ，用 gridview 替换掉，然后那几个参数传 all 的，采用随机参数替换掉"),
    Todo(false, "首页的  历史上的今天 ，添加一个默认的数据，用 json 来存储一下，防止 100 次调完了没数据看了。。。"),
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



/// 首页，历史上的今天，以为接口调用次数有限制，所以采用如下策略：每天的第一次调用，返回的 json 数据进行本地保存，之后的每一次调用，都
/// 先从缓存中取，有则直接用缓存的数据，没有就去重新拉取，以为这个数据每天都是返回一样的。。。
/// 