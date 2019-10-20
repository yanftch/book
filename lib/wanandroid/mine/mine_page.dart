import 'package:book/framework/channels/app.dart';
import 'package:book/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:book/domins.dart';
import 'package:book/http.dart' show HttpImpl;
import 'package:book/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

///
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin, AppChannels {
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

  var list = ["111111", "222222", "333333", "444444"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mine"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("demo"),
            onPressed: () {
              Navigator.pushNamed(context, '/widgets_for_week');
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  // todo 根据是否登录来判断是否显示 user info page
  var hasLoging = false;

  Widget _buildBody() => hasLoging ? Container() : _buildUnLoginWidget();

  Widget _buildLoginWidget() => null;

  Widget _buildUnLoginWidget() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Text("login"),
            ),
            InkWell(
              child: Text("去登录",
                  style: TextStyle(fontSize: 32.0, color: Colors.black87)),
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
            Container(
              child: RoundLinearProgressIndicator(
                value: 0.8,
              ),
              padding: const EdgeInsets.all(20),
            ),
          ],
        ),
        alignment: Alignment.center,
      );

  void requestPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);

    permissions.forEach((p, status) {
      print("PermissionGroup--->${p}    status======>$status");
    });
  }

  Widget _body3() => Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.cloud_circle),
              onPressed: () {
                var date = DateTime.now();
                var millisecond = date.millisecondsSinceEpoch;
                print("now=====$date");
                print("millisecond=====$millisecond");
                String timestamp =
                    "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                print("timestamp=====$timestamp");
                print("utils=====${DateUtils.month}/${DateUtils.day}");

                showNativeToast(message: "Flutter 调用了原生的 toast");
              },
            ),
            InkWell(
              child: Text(
                "open native page : book://test_page?id=998877",
                style: TextStyle(fontSize: 20.0),
              ),
              onTap: () {
                openAppPage(url: "book://test_page?id=998877");
              },
            ),
            FlatButton(
              child: Text("permission for camera"),
              onPressed: () {
                requestPermissions();
              },
            )
          ],
        ),
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
