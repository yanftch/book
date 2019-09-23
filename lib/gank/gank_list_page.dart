import 'package:book/domins.dart' show GankCategory, GankInfo;
import 'package:flutter/material.dart';
import 'package:book/http.dart' show HttpGankUtils;
import 'package:book/widgets.dart' show FetchResult, GankCategoryWidget;
import 'package:book/widgets.dart' show PullRefreshGridState, PullRefreshGrid;
import 'package:book/styles.dart' show Styles;
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:book/ui_helper.dart' show platformProgressIndicator;
import '../framework.dart';
import 'package:async/async.dart' show CancelableOperation;
import 'package:flutter/cupertino.dart' show CupertinoSliverRefreshControl;

enum RefreshStatus {
  /// Idle
  idle,

  /// Refreshing the whole list
  refreshing,

  /// Pre-loading the next page
  loadingMore,

  /// There's no more pages
  noMore,

  /// Failed fetching data
  failed,
}

/// Gank 个类别列表页面
///
class GankCategoryListPage extends StatefulWidget {
  /// 类别
  String category = "all"; // 默认设置为 all

  GankCategoryListPage({this.category});

  @override
  _GankCategoryListPageState createState() => _GankCategoryListPageState();
}

class _GankCategoryListPageState extends State<GankCategoryListPage> {
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  RefreshStatus _pullRefreshStatus = RefreshStatus.idle;
  CancelableOperation _cancelableFetching;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  double screenHeight;

  bool get isFetchingAllowed =>
      _pullRefreshStatus == RefreshStatus.idle ||
      _pullRefreshStatus == RefreshStatus.failed;

  /// 数据源
  List<GankInfo> datas = [];

  void cancelFetching() {
    _cancelableFetching?.cancel();
  }

  @override
  void initState() {
    super.initState();
    animatedRefresh();

    _scrollController.addListener(() {
      var pos = _scrollController.position;
      final atBottom = pos.maxScrollExtent - pos.pixels < 200;
      if (atBottom && isFetchingAllowed) {
        _fetchDatas(true);
      } else {}

      var offset = _scrollController.position.maxScrollExtent;
      var screenHeight = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: _buildPullRefresh(),
    );
  }

  Widget _buildPullRefresh() {
    var body = CustomScrollView(
      physics: isIOS
          ? const BouncingScrollPhysics()
          : AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: <Widget>[
        if (isIOS)
          CupertinoSliverRefreshControl(
            onRefresh: _fetchDatas,
          ),
        _buildGrid(context),
        _buildBottom(),
      ],
    );
    return isIOS
        ? body
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _fetchDatas,
            child: body,
          );
  }

  void animatedRefresh({bool clean = false}) {
    if (clean)
      setState(() {
        datas.clear();
        _pullRefreshStatus = RefreshStatus.idle;
      });

    // 确保在[build]之后执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        isIOS
            ? _scrollController.jumpTo(-200) // jumpTo可模拟触发下拉刷新
            : _refreshIndicatorKey.currentState?.show();
      }
    });
  }

  Future<void> _fetchDatas([bool isIncrement = false]) async {
    // print("object_fetchDatas: _pullRefreshStatus===$_pullRefreshStatus");
    if (!mounted) return Future.value();
    if (!isIncrement) {
      /// 取消请求
      // _cancelableFetching.cancel();

      _pullRefreshStatus = RefreshStatus.idle;
    }
    setState(() {
      _pullRefreshStatus =
          isIncrement ? RefreshStatus.loadingMore : RefreshStatus.refreshing;
    });
    // _cancelableFetching =  CancelableOperation.fromFuture(dataFetcher(isIncremental));

    // await Future.delayed(Duration(milliseconds: 3000));
    List<GankInfo> infoList =
        await HttpGankUtils.fetchCategoryDatas(widget.category, isIncrement);

    var list = infoList;

    setState(() {
      if (list.length > 0) {
        datas.addAll(list);
        _pullRefreshStatus = RefreshStatus.idle;
      } else {
        _pullRefreshStatus = RefreshStatus.noMore;
      }
    });
    return Future.value();
  }

  List<GankInfo> generateDatas() {
    var length = datas.length;
    if (length > 100) return [];
    List<GankInfo> list = [];
    for (int i = 0; i < 20; i++) {
      int newIndex = length + i;
      list.add(GankInfo(desc: "Item $newIndex"));
    }
    return list;
  }

  /// 渲染列表
  Widget _buildGrid(BuildContext context) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        delegate: SliverChildBuilderDelegate(
            (context, index) => _buildItem(index),
            childCount: datas.length),
      );

  Widget _buildItem(int index) {
    Color randomColor =
        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

    return (widget.category != '福利'
        ? GestureDetector(
            child: Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        color: randomColor,
                        height: 100,
                        child: datas[index].imgUrl().isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: "${datas[index].imgUrl()}",
                              )
                            : null),
                    Text(
                      "${datas[index].desc}",
                      style: Styles.titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "作者 : ${datas[index].who}",
                      style: TextStyle(color: randomColor),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              _itemClick(datas[index]);
            },
          )
        : _buildBeauty(datas[index]));
  }

  Widget _buildBeauty(GankInfo info) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: CachedNetworkImage(
          imageUrl: info.url,
          width: 100,
          height: 200,
          errorWidget: (context, url, error) {
            return Container(
              alignment: Alignment.center,
              child: Text("url error"),
              color: Colors.grey,
            );
          }),
    );
  }

  void _itemClick(GankInfo item) {
    Navigator.pushNamed(context, "/detail?title=${item.desc}&url=${item.url}");
  }

  Widget _buildBottom() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: buildLoadingMoreIndicator(),
      ),
    );
  }

  Widget buildLoadingMoreIndicator() {
    // print("buildLoadingMoreIndicator------>状态    ${_pullRefreshStatus}");

    var content;
    switch (_pullRefreshStatus) {
      case RefreshStatus.loadingMore:
        content = platformProgressIndicator();
        break;
      case RefreshStatus.noMore:
        content = Text("No more~");
        break;
      default:
        content = const SizedBox();
        break;
    }
    return content;
  }
}
