import 'package:flutter/widgets.dart';

export './pull_refresh.dart';
import './pull_refresh.dart';

/// 可下拉刷新的Grid视图
///
/// - 上层组件需区分平台分别使用[CupertinoPageScaffold]或[Scaffold]，考虑使用封装好的[platformScaffold]
/// - 目前封装为一个单纯的组件, 如果需要`NavigationBar`联动的滑动效果, 须考虑按整个页面封装
class PullRefreshGrid<T> extends StatefulWidget {
  /// 列表Cell的[WidgetBuilder]
  final ItemBuilder<T> itemBuilder;

  /// Grid有多少列 默认2
  final int columnCount;

  /// 单元格的宽高比 默认1
  final double cellAspectRatio;

  /// 驻留Header构造器，不算在[headerCount]里
  final WidgetBuilder persistentHeaderBuilder;

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

  /// 底部留白空间，用在loading more组件，可以定制以便增加额外的空间
  final double bottomPadding;

  /// 构造[PullRefreshGrid]实例.
  ///
  /// - 列表数据由[dataFetcher]负责加载，单条数据由[itemBuilder]负责渲染
  /// - [columnCount]表示有多少列, [cellAspectRatio]则为单元格的宽高比
  /// - 自定义[bottomPadding]可增加底部的边距
  /// - 可设置[headerCount]个header，由[headerBuilder]负责渲染
  /// - 可设置[footerCount]个footer，由[footerBuilder]负责渲染
  /// - 设置[scrollingCallback]可得到列表滑动事件的通知
  PullRefreshGrid({
    Key key,
    @required this.dataFetcher,
    @required this.itemBuilder,
    this.columnCount = 2,
    this.cellAspectRatio = 1,
    this.bottomPadding = 20,
    this.persistentHeaderBuilder,
    this.headerCount = 0,
    this.headerBuilder,
    this.footerCount = 0,
    this.footerBuilder,
    this.scrollingCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PullRefreshGridState<T>();
}

/// [State] of [PullRefreshGrid]
class PullRefreshGridState<T> extends PullRefreshableState<PullRefreshGrid<T>, T> {

  @override
  get dataFetcher => widget.dataFetcher;

  @override
  get scrollingCallback => widget.scrollingCallback;

  @override
  get bottomPadding => widget.bottomPadding;

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
    contentBuilder: (context) => SliverGrid(
      delegate: SliverChildBuilderDelegate(
        pullRefreshItemBuilder(widget.itemBuilder),
        childCount: pullRefreshData.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // TODO 避免写死列数和宽高比
        crossAxisCount: widget.columnCount,
        childAspectRatio: widget.cellAspectRatio,
      ),
    ),
    persistentHeaderDelegateBuilder: widget.persistentHeaderBuilder,
    headerCount: widget.headerCount,
    headerBuilder: widget.headerBuilder,
    footerCount: widget.footerCount + 1, // 加一个load more视图
    footerBuilder: _buildFooter,
  );

  /// `load morea`试图需要占满一行，通过footer实现，目前放在所有footer的最上面
  Widget _buildFooter(BuildContext context, int index) => index == 0
      ? buildLoadingMoreIndicator(context, index)
      : widget.footerBuilder(context, index - 1);
}
