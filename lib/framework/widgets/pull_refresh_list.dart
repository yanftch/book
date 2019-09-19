import 'package:flutter/widgets.dart';

export 'package:book/framework/widgets/pull_refresh.dart';
import 'package:book/framework/widgets/pull_refresh.dart';

/// 可下拉刷新的列表组件, 并封装翻页预加载行为
///
/// - 上层组件需区分平台分别使用[CupertinoPageScaffold]或[Scaffold]，考虑使用封装好的[platformScaffold]
/// - 目前封装为一个单纯的组件, 如果需要`NavigationBar`联动的滑动效果, 须考虑按整个页面封装
class PullRefreshList<T> extends StatefulWidget {
  /// 列表Cell的[WidgetBuilder]
  final ItemBuilder<T> itemBuilder;

  /// Header数量
  final int headerCount;

  /// Header渲染器
  final IndexedWidgetBuilder headerBuilder;

  /// Footer数量
  final int footerCount;

  /// Footer渲染器
  final IndexedWidgetBuilder footerBuilder;

  /// 列表Cell的[WidgetBuilder]
  final DataFetcher<T> dataFetcher;

  /// 列表滑动事件回调
  final ScrollingCallback scrollingCallback;

  /// 构造[PullRefreshList]实例.
  ///
  /// - 列表数据由[dataFetcher]负责加载，单条数据由[itemBuilder]负责渲染
  /// - 可设置[headerCount]个header，由[headerBuilder]负责渲染
  /// - 可设置[footerCount]个footer，由[footerBuilder]负责渲染
  /// - 设置[scrollingCallback]可得到列表滑动事件的通知
  PullRefreshList({
    Key key,
    @required this.dataFetcher,
    @required this.itemBuilder,
    this.headerCount = 0,
    this.headerBuilder,
    this.footerCount = 0,
    this.footerBuilder,
    this.scrollingCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PullRefreshListState<T>();
}

/// 封装[State<PullRefreshList>]的基本逻辑, 由子类提供平台特定的交互行为
class _PullRefreshListState<T> extends PullRefreshableState<PullRefreshList<T>, T> {

  @override
  get dataFetcher => widget.dataFetcher;

  @override
  get scrollingCallback => widget.scrollingCallback;

  @override
  void initState() {
    super.initState();
    initPullRefreshState();
  }

  @override
  void dispose() {
    cancelFetching();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => buildPullRefresh(context,
    contentBuilder: (context) => SliverList(
      delegate: SliverChildBuilderDelegate(
        pullRefreshItemBuilder(widget.itemBuilder),
        childCount: pullRefreshData.length + 1,
      ),
    ),
    headerCount: widget.headerCount,
    headerBuilder: widget.headerBuilder,
    footerCount: widget.footerCount,
    footerBuilder: widget.footerBuilder,
  );
}
