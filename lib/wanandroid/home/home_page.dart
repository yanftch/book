import 'package:book/utils/date_utils.dart';
import 'package:book/utils/sp_util.dart';
import 'package:book/utils/t.dart';
import 'package:flutter/material.dart';
import 'package:book/http.dart' show HttpImpl;
import 'package:book/domins.dart';
import 'package:book/widgets.dart'
    show PullRefreshGridState, PullRefreshList, BottomSheetView;
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:book/styles.dart';
import 'package:book/framework.dart' show isNotEmpty;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:ui' as ui;
import 'package:book/cache.dart';

// TODO title 和 subtitle 的 Text，样式各自统一的话，可以考虑分别封装不同的 Text，自带样式。

/// 首页
///
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _pullRefreshKey = GlobalKey<PullRefreshGridState>();

//  final _cartFabKey = GlobalKey<FlashDealCartFabState>();

  List<HomeBannerBean> _bannerDatas = [];
  List<History> _historyDatas = [];

  /// 为了支持 BottomSheet 可以在别的地方调用
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchBannerData();
    fetchHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: _buildActionBarButton(),
      ),
      body: _buildList(context),
    );
  }

  // 构建标题栏右上角按钮数组
  List<Widget> _buildActionBarButton() => [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            T.show("to do");
            Navigator.pushNamed(context, "/wanandroid_search");
          },
        )
      ];

  /// 渲染列表
  Widget _buildList(BuildContext context) => PullRefreshList<HomeItemBean>(
        key: _pullRefreshKey,
        dataFetcher: HttpImpl.fetchHomeListApi,
        itemBuilder: _buildItem,
        headerCount: 1,
        headerBuilder: _builderHeader,
        scrollingCallback: _onScroll,
      );

  /// 列表滚动事件
  void _onScroll(ScrollPosition position) async {
    if (!mounted) return; // iOS目前不需要报告scroll事件
    if (mounted)
      _updateCartFabPosition(position); // 等消息先发给原生层（导航栏可能有变化）再更新FAB位置
  }

  /// 更新加入购物车按钮的位置
  /// 目前针对Android：原生顶部/底部导航栏的动态隐藏效果，使FlutterView的位置/size发生变化，导致FAB的位置不正确
  void _updateCartFabPosition(ScrollPosition position) {
    double bottom;
    final y = position.pixels.toInt();
    final direction = position.userScrollDirection;
    if (y == 0 && position.atEdge)
      bottom = 175; // 顶部/底部导航都显示，FAB位置需要高一点
    else if (direction == ScrollDirection.forward)
      bottom = 75; // 底部导航显示，升高FAB
    else if (direction == ScrollDirection.reverse)
      bottom = 30; // 顶部/底部导航都隐藏，FAB可以低一点

//    if (bottom != null) _cartFabKey.currentState?.updatePosition(
//        bottom: bottom);
  }

  /// Header渲染器。显示 banner
  Widget _builderHeader(BuildContext context, int index) {
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

    return Column(
      children: <Widget>[
        _bannerDatas.isNotEmpty
            ? Container(
                height: screenWidth * 5 / 9,
                child: Swiper(
                  onTap: (index) {
                    Navigator.pushNamed(context,
                        "/detail?title=${_bannerDatas[index].title}&url=${_bannerDatas[index].url}");
                  },
                  pagination:
                      SwiperPagination(alignment: Alignment.bottomRight),
                  autoplay: true,
                  itemCount: _bannerDatas.length ?? 0,
                  itemBuilder: (context, index) => Image.network(
                    _bannerDatas[index].imagePath,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              )
            : SizedBox(),
        _historyDatas.isNotEmpty
            ? Container(
                height: 40,
                alignment: Alignment.center,
                child: Swiper(
                  onTap: (index) {
                    _showBottomSheet(_historyDatas[index].eId);
                  },
                  autoplay: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _historyDatas.length ?? 0,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              "${_historyDatas[index].title}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  void _onItemClick(HomeItemBean item) {
    Navigator.pushNamed(
        context, "/detail?title=${item.title}&url=${item.link}");
  }

  void _showBottomSheet(String param) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetView(param: param),
    );
  }

  /// 获取 banner 数据
  void fetchBannerData() async {
    List<HomeBannerBean> banners = await HttpImpl.fetchHomeBanner();
    if (banners.isNotEmpty) {
      setState(() {
        _bannerDatas.addAll(banners);
        print("banners.length--->${_bannerDatas.length}");
      });
    }
  }

  /// 获取历史上的今天的数据
  void fetchHistories() async {
    var date = "${DateUtils.month}/${DateUtils.day}";
    List<History> historys = await HttpImpl.getHistories(date);
    print("historys.length-------->${historys.length}");
    if (historys.isNotEmpty) {
      // 本地缓存
      Cache.cacheHomeHistorys(historys);
      setState(() {
        _historyDatas.clear();
        _historyDatas.addAll(historys);
      });
    } else {
      var list = Cache.getHomeHistorys();
      setState(() {
        _historyDatas.clear();
        _historyDatas.addAll(list);
      });
    }
  }

  /// 构建 Item
  Widget _buildItem(BuildContext context, HomeItemBean item, int index) =>
      GestureDetector(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${item.title}",
                  style: Styles.titleStyle,
                ),
                SizedBox(height: 6),
                isNotEmpty(item.desc)
                    ? Text(item.desc, style: Styles.subtitleStyle)
                    : SizedBox(),
                Text(
                  "${item.author}",
                  style: Styles.subtitleStyle,
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.access_time, color: Styles.subTitleColor),
                        Text(
                          item.niceDate,
                          style: Styles.subtitleStyle,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.account_box, color: Styles.subTitleColor),
                        Text(item.author, style: Styles.subtitleStyle)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "类别: " +
                      (isNotEmpty(item.superChapterName)
                          ? "${item.superChapterName}/"
                          : "") +
                      (isNotEmpty(item.chapterName) ? item.chapterName : ""),
                  style: Styles.subtitleStyle,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _onItemClick(item);
        },
      );
}
