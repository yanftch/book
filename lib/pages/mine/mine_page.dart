import 'package:flutter/material.dart';
import 'package:book/domins.dart';
import 'package:book/http.dart' show HttpImpl;
import 'package:book/widgets.dart';
///
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  final _key = GlobalKey();

  @override
  bool get wantKeepAlive => true;
  int total;
  List<GankInfo> results = [];
  Future _future;
  PageRequest<GankInfo> _pageRequest;
  @override
  void initState() {
    super.initState();
    _future = getRandomDataCopy();
    _pageRequest = getRandomDataCopy2;
  }
  var list  = ["111111","222222","333333","444444"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mine"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("click==$total"),
            onPressed: () {
              Navigator.pushNamed(context, '/test');
            },
          )
        ],
      ),
      body: _body3(),
    );
  }

  Widget _body3() => Container(

  );

  Widget _body2() => Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              key: _key,
              child: Text("left"),
              onPressed: () {
                PopupWindow.showPopWindow(
                    context,
                    "hello",
                    _key,
                    PopDirection.top,
                    Container(
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Text("delete"),
                            onPressed: () {
                              print("object---click delete");
                            },
                          )
                        ],
                      ),
                    ));
              },
            ),
          ],
        ),
      );

  Widget _body() => Container(
        child: FutureBuilder<List<GankInfo>>(
          future: _future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text("ready to load..........."),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                return _buildList();
                break;
              default:
            }
            return SizedBox();
          },
        ),
      );

  Widget _buildList() => ListViewWidget<GankInfo>(_pageRequest, _buildItemCopy);

  Widget _buildItem(BuildContext context, int index) => Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text("${results[index].createdAt}"),
        ),
      );
  Widget _buildItemCopy(List<GankInfo> datas, int index) => Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Text("${datas[index].createdAt}"),
        ),
      );

  /// 获取 IOS 列表数据
  void getRandomData() async {
    GankCategory category = await HttpImpl.getIOSDatas(0);
    print("gank--->${category.results.length}");
    setState(() {
      total = category.results.length;
      results.clear();
      results.addAll(category.results);
    });
  }

  Future<List<GankInfo>> getRandomDataCopy() async {
    GankCategory category = await HttpImpl.getIOSDatas(0);
    List<GankInfo> lists = category.results;
    print("gank--->${category.results.length}");
    setState(() {
      total = lists.length;
      results.clear();
      results.addAll(lists);
    });
    return Future<List<GankInfo>>.value(lists);
  }

  Future<List<GankInfo>> getRandomDataCopy2(int page, int pageSize) async {
    GankCategory category = await HttpImpl.getIOSDatas(0);
    List<GankInfo> lists = category.results;
    print("gank--->${category.results.length}");
    setState(() {
      total = lists.length;
      results.clear();
      results.addAll(lists);
    });
    return Future<List<GankInfo>>.value(lists);
  }
}
