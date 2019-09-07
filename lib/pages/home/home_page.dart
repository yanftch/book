import 'package:book/http.dart' show NetManager;
import 'package:flutter/material.dart';
import 'package:book/domins.dart' show HomeItemBean, HomeBean;

/// 首页
///
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HomeItemBean> datas = [];
  var listViewController = ScrollController();
  //记录当前页码，实现分页
  int pageNo = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchData(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: _buildActionBarButton(),
      ),
      body: Center(
        child: RefreshIndicator(
          child: _buildContent(),
          onRefresh: () => _fetchData(0),
        ),
      ),
    );
  }

  // 构建标题栏右上角按钮数组
  List<Widget> _buildActionBarButton() => [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ];

  /// 构建主界面内容
  Widget _buildContent() {
    return datas.isEmpty
        ? CircularProgressIndicator()
        : ListView.builder(
            controller: listViewController,
            itemCount: datas.length,
            itemBuilder: (content, index) => _buildItem(index),
          );
  }

  /// 构建 Item
  Widget _buildItem(int index) => Card(
        child: Column(
          children: <Widget>[
            Text("title ${datas[index].title}"),
            Text("author ${datas[index].author}"),
          ],
        ),
      );

  /// 获取列表数据
  Future<Null> _fetchData(int pageNo) async {
    HomeBean homeBean = await NetManager.homeListApi(context, 0);
    bool increment = pageNo != 0;
    _refreshDatas(homeBean.datas, increment: increment);
    return null;
  }

  void _refreshDatas(List<HomeItemBean> list, {bool increment = false}) {
    setState(() {
      if (!increment) {
        datas.clear();
      }
      datas.addAll(list);
    });
  }
}
