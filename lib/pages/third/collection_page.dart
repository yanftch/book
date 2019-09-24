import 'package:book/domins.dart';
import 'package:book/framework.dart';
import 'package:book/utils/sqlite_helper.dart';
import 'package:flutter/material.dart';

/// 收藏页面
class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  /// 初始化 数据库工具类
  DbHelper helper;

  List<DbModel> _list = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();

    /// 获取全部数据
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: _list.isEmpty ? _buildEmptyView() : _buildList(),
        onRefresh: () {
          getAll();
          return Future.value();
        },
      ),
    );
  }

  Widget _buildList() => Container(
        child: ListView.builder(
          itemBuilder: (context, index) => _buildItem(_list[index]),
          itemCount: _list.length,
        ),
      );
  Widget _buildItem(DbModel model) => GestureDetector(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: Text("${model.title.substring(0, 1)}"),
                  backgroundColor: Colors.green[500],
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.titleStyle,
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          model.type,
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(4.0)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _itemClick(model.title, model.url);
        },
      );

  void _itemClick(String title, String url) =>
      Navigator.pushNamed(context, "/detail?title=$title&url=$url");

  Widget _buildEmptyView() => Container(
        alignment: Alignment.center,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/placeholder.png'),
            Text("收藏为空"),
          ],
        ),
      );

  void getAll() async {
    var items = await helper.getModels();
    setState(() {
      if (items != null && items.isNotEmpty) {
        _list.clear();
        _list.addAll(items);
      }
    });
  }

  void getItem() async {
    var item = await helper.getModel(1);
    print("----item=====${item.toString()}}");
  }

  void getItems() async {
    var items = await helper.getModels();
    print("----items===all==${items.length}}");

    items.forEach((v) {
      print("get.all----->$v");
    });
  }
}
