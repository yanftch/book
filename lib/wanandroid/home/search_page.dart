import 'package:book/utils/t.dart';
import 'package:book/wanandroid/home/search_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:book/widgets.dart';
import 'package:book/domins.dart' show HotKey;

/// 搜索列表页面
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  _SearchPageState() : _viewModel = SearchPageViewModel();
  final SearchPageViewModel _viewModel;
  List<HotKey> hotKeys = [];
  List<HotKey> historyKeys = [];

  @override
  void initState() {
    super.initState();
    _fetchKeys();
    historyKeys.clear();
    historyKeys.addAll(_viewModel.get().map((value) {
      return HotKey(name: value);
    }).toList());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: SearchAppBar(
          placeholder: "请输入...",
          onComplete: (txt) {
            print("object-----$txt");
            _viewModel.save(txt);
            setState(() {
              historyKeys.clear();
              historyKeys.addAll(_viewModel.get().map((value) {
                return HotKey(name: value);
              }).toList());
            });
          },
        ),
        body: SingleChildScrollView(
          child: _buildBody(),
        ),
      );

  Widget _buildBody() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            _buildHot(),
            _buildHistory(),
          ],
        ),
      );
  Widget _buildHot() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    "热门搜索",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ),
                Positioned(
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.refresh),
                        Text(
                          "换一换",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        )
                      ],
                    ),
                    onTap: () {
                      _fetchKeys();
                    },
                  ),
                  right: 0,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 200),
              child: hotKeys.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Wrap(
                      spacing: 10,
                      children: _buildChips(hotKeys),
                    ),
            )
          ],
        ),
      );

  Widget _buildHistory() => Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("历史搜索",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54)),
                historyKeys.length > 0
                    ? ActionChip(
                        onPressed: () {
                          _viewModel.clear();
                          setState(() {
                            historyKeys.clear();
                          });
                        },
                        avatar: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.black38,
                        ),
                        label: Text("清除",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black38)),
                      )
                    : SizedBox(),
              ],
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 200),
              child: historyKeys.length == 0
                  ? Center(
                      child: Image.asset("assets/empty.jpg",
                          width: 100, height: 100),
                    )
                  : Wrap(
                      spacing: 10,
                      children: _buildChips(historyKeys),
                    ),
            )
          ],
        ),
      );

  List<Widget> _buildChips(List<HotKey> list) => list
      .map(
        (key) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Chip(
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            label: Text(key.name),
          ),
          onTap: () {
            T.show("${key.name} / ${key.id}");
          },
        ),
      )
      .toList();

  Future _fetchKeys() async {
    _viewModel.fetchHotKeys().then((value) => _onDataFetched(value));
  }

  void _onDataFetched(List<HotKey> hot) {
    if (hotKeys == null || !mounted) return;
    debugPrint("get hot keys: ${hot.toString()}");
    setState(() {
      hotKeys.clear();
      hotKeys.addAll(hot);
    });
  }
}
