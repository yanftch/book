import 'package:book/domins.dart' show GankCategory, GankInfo;
import 'package:flutter/material.dart';
import 'package:book/http.dart' show HttpGankUtils;
import 'package:book/widgets.dart' show GankCategoryWidget;
import 'package:book/widgets.dart' show PullRefreshGridState, PullRefreshList;
import 'package:book/styles.dart' show Styles;

/// homepage for [gank]
/// todo 添加右上角的搜索框
class GankHomePage extends StatefulWidget {
  @override
  _GankHomePageState createState() => new _GankHomePageState();
}

class _GankHomePageState extends State<GankHomePage> {
  final _pullRefreshKey = GlobalKey<PullRefreshGridState>();

  bool isLoading = false;

  /// 数据源
  List<GankInfo> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildList(context),
    );
  }

  /// 渲染列表
  Widget _buildList(BuildContext context) => PullRefreshList<GankInfo>(
        key: _pullRefreshKey,
        dataFetcher: HttpGankUtils.fetchiOSListApi,
        itemBuilder: _buildItem,
        headerCount: 1,
        headerBuilder: _builderHeader,
        scrollingCallback: _onScroll,
      );

  /// 构建子布局
  Widget _buildItem(BuildContext context, GankInfo data, int index) =>
      GestureDetector(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: Image.network(data.imgUrl(), width: 100, height: 100),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data.desc,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.titleStyle,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.info,
                              size: 12,
                              color: Colors.black45,
                            ),
                            Text(
                              " ${data.type}",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                            SizedBox(width: 16.0),
                            Icon(
                              Icons.adjust,
                              size: 12,
                              color: Colors.black45,
                            ),
                            Text(
                              " ${data.who}",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                            SizedBox(width: 16.0),
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: Colors.black45,
                            ),
                            Text(
                              " ${data.showTime()}",
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45),
                            ),
                            SizedBox(width: 16.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          _itemClick(data);
        },
      );

  void _itemClick(GankInfo item) {
    Navigator.pushNamed(context, "/detail?title=${item.desc}&url=${item.url}");
  }

  Widget _builderHeader(BuildContext context, int index) =>
      GankCategoryWidget();

  /// 列表滚动事件
  void _onScroll(ScrollPosition position) async {
    if (!mounted) return; // iOS目前不需要报告scroll事件
  }

  /// 获取 IOS 列表数据
  void getRandomData() async {
    GankCategory category = await HttpGankUtils.getIOSDatas(0);
    print("gank--->${category.results.length}");
  }
}
