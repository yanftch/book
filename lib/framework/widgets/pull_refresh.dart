import 'dart:math';

import 'package:async/async.dart' show CancelableOperation;
import 'package:flutter/cupertino.dart' show CupertinoSliverRefreshControl;
import 'package:flutter/material.dart';
import 'package:book/framework.dart' show isIOS;
import 'package:book/ui_helper.dart' show platformProgressIndicator;

/// [PullRefresh]组件的状态
enum PullRefreshStatus {
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

/// 列表数据加载结果
@immutable
class FetchResult<T> {
  /// 构造包含[data]的[FetchResult]实例，[hasMore]表示是否还有更多数据，默认为`true`
  const FetchResult(this.data, [this.hasMore = true]);

  /// 本次加载的结果集
  final List<T> data;

  /// 是否还有更多数据
  final bool hasMore;
}

/// 加载列表数据的函数定义, [isIncremental]指定是否增量加载
typedef DataFetcher<T> = Future<FetchResult<T>> Function(bool isIncremental);

/// 列表Cell的[WidgetBuilder]函数定义
typedef ItemBuilder<T> = Widget Function(BuildContext, T, int);

/// 屏幕滑动事件回调
typedef ScrollingCallback = void Function(ScrollPosition);

/// 封装下拉刷新组件的基本逻辑，以及平台特定的交互行为
abstract class PullRefreshableState<W extends StatefulWidget, T>
    extends State<W> {
  DataFetcher<T> dataFetcher;
  ScrollingCallback scrollingCallback;

  /// 底部留白空间，用在loading more组件，可以定制以便增加额外的空间
  double bottomPadding = 20;

  /// 列表数据
  final List<T> pullRefreshData = [];

  /// 当前状态
  PullRefreshStatus get pullRefreshStatus => _pullRefreshStatus;
  PullRefreshStatus _pullRefreshStatus = PullRefreshStatus.idle;

  /// 判断当前是否还有更多数据可以加载 (用于翻页)
  bool get isFetchingAllowed =>
      _pullRefreshStatus == PullRefreshStatus.idle ||
      _pullRefreshStatus == PullRefreshStatus.failed;

  /// 当前的数据请求，可取消
  CancelableOperation _cancelableFetching;

  /// 用于监听列表滑动事件
  /// FIXME iOS目前PrimaryScrollController.of得到null，无法实现点击状态栏回到顶部
  final pullRefreshController = ScrollController();

  /// 用于引用[RefreshIndicatorState]的[Key], Android Only
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  /// 初始化下拉刷新组件状态
  void initPullRefreshState() {
    animatedRefresh();

    // 滑动接近底部时触发预加载
    pullRefreshController.addListener(() {
      // FIXME 如果第一页不满一屏不会触发loadMore
      final pos = pullRefreshController.position;
      final atBottom = pos.maxScrollExtent - pos.pixels < 200;
      // debugPrint("--- onScrolling pos=$pos ${pos.pixels}/${pos.maxScrollExtent} edge=${pos.atEdge} bottom=$atBottom");
      if (atBottom && isFetchingAllowed) {
        fetchData(true);
      }
      scrollingCallback?.call(pos);
    });
  }

  /// 包装[IndexedWidgetBuilder].
  ///
  /// 底部附加一行显示loading more，其余位置展示数据
  IndexedWidgetBuilder pullRefreshItemBuilder(ItemBuilder<T> itemBuilder) =>
      (BuildContext context, int index) => pullRefreshData.length == index
          ? buildLoadingMoreIndicator(context, index)
          : itemBuilder(context, pullRefreshData[index], index);

  /// Footer, 展示loading more
  Widget buildLoadingMoreIndicator(BuildContext context, int index) {
    var content;
    switch (_pullRefreshStatus) {
      case PullRefreshStatus.loadingMore:
        content = platformProgressIndicator();
        break;
      case PullRefreshStatus.noMore:
        content = Text("No more~");
        break;
      default:
        content = const SizedBox();
        break;
    }

    return Container(
      padding:
          EdgeInsets.only(left: 16, right: 16, top: 20, bottom: bottomPadding),
      child: Center(child: content),
    );
  }

  /// 程序触发的下拉刷新, [clean]可指定是否先清除数据
  void animatedRefresh({bool clean = false}) {
    if (clean)
      setState(() {
        pullRefreshData.clear();
        _pullRefreshStatus = PullRefreshStatus.idle;
      });

    // 确保在[build]之后执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        isIOS
            ? pullRefreshController.jumpTo(-200) // jumpTo可模拟触发下拉刷新
            : _refreshIndicatorKey.currentState?.show();
      }
    });
  }

  /// 取消未完成的网络请求，如果有的话
  void cancelFetching() {
    _cancelableFetching?.cancel();
  }

  /// 加载数据
  Future<void> fetchData([bool isIncremental = false]) {
    if ((isIncremental && !isFetchingAllowed) || !mounted)
      return Future.value();

    if (!isIncremental) {
      // 整体刷新时，先取消未完成的请求，重新发请求
//      debugPrint("---- cancel prev fetching ----");
      _cancelableFetching?.cancel();
      _pullRefreshStatus = PullRefreshStatus.idle;
    }

    setState(() => _pullRefreshStatus = isIncremental
        ? PullRefreshStatus.loadingMore
        : PullRefreshStatus.refreshing);
    _cancelableFetching =
        CancelableOperation.fromFuture(dataFetcher(isIncremental));

    return _cancelableFetching.value.then((result) {
      if (result == null || !mounted) return;
      setState(() {
        if (!isIncremental) pullRefreshData.clear();
        if (result.data != null) pullRefreshData.addAll(result.data);
        _pullRefreshStatus = result.hasMore == true
            ? PullRefreshStatus.idle
            : PullRefreshStatus.noMore;
      });
    }).catchError((e) {
      setState(() => _pullRefreshStatus = PullRefreshStatus.failed);
      debugPrint("Failed fetching data: $e");
    });
  }

  /// 渲染下拉刷新组件
  /// - [persistentHeaderDelegateBuilder]可用于构造驻留的header，不算在[headerCount]里面
  Widget buildPullRefresh(
    BuildContext context, {
    @required WidgetBuilder contentBuilder,
    int headerCount = 0,
    IndexedWidgetBuilder headerBuilder,
    int footerCount = 0,
    IndexedWidgetBuilder footerBuilder,
    WidgetBuilder persistentHeaderDelegateBuilder,
  }) {
    final body = CustomScrollView(
      physics: isIOS
          ? const BouncingScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      controller: pullRefreshController,
      slivers: <Widget>[
        // ios11的新样式，必须有一个largeTitle，滑动时可以collapse到顶部中间
        // CupertinoSliverNavigationBar(
        //  largeTitle: Text(isFollowings ? l10n?.followingsTitle : l10n?.followersTitle),
        // ),
        if (persistentHeaderDelegateBuilder != null)
          persistentHeaderDelegateBuilder(context),

        if (isIOS)
          CupertinoSliverRefreshControl(
            onRefresh: fetchData,
          ),

        // Headers 不使用CupertinoSliverNavigationBar，需要使用SliverSafeArea，避免被状态栏遮挡
        if (headerCount > 0)
          _buildSliverList(headerCount, headerBuilder),

        // Content
        contentBuilder(context),

        // Footers
        if (footerCount > 0)
          _buildSliverList(footerCount, footerBuilder),
      ],
    );

    return isIOS
        ? body
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: fetchData,
            child: body,
          );
  }

  Widget _buildSliverList(int count, IndexedWidgetBuilder builder) =>
      SliverList(
        delegate: SliverChildBuilderDelegate(builder, childCount: count),
      );
}

/// 构造可伸缩的[CustomScrollView] header
SliverPersistentHeader makePersistentHeader({
  @required double minHeight,
  @required double maxHeight,
  @required Widget child,
}) =>
    SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: child,
      ),
    );

/// 可伸缩的[CustomScrollView] header
/// 参考: https://medium.com/flutter/slivers-demystified-6ff68ab0296f
class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// 可伸缩的[CustomScrollView] header
  const PersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      SizedBox.expand(child: child);

  @override
  bool shouldRebuild(PersistentHeaderDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
