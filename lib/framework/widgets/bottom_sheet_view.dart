import 'package:flutter/material.dart';
import 'package:book/http.dart' show HttpImpl;
import 'package:book/domins.dart' show History, HistoryModel;

/// 底部弹出的bottom_sheet 组件
///
class BottomSheetView extends StatefulWidget {
  final String param;

  BottomSheetView({@required this.param});

  @override
  _BottomSheetViewState createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  Future _future;
  HistoryModel _historyModel;
  History _history = History();

  @override
  void initState() {
    super.initState();
    _future = fetchDetail();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _body(),
        backgroundColor: Colors.transparent,
      );

  Widget _body() => Container(
        constraints: BoxConstraints(maxHeight: 800, minHeight: 600),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: Padding(
          child: _buildContent(),
          padding: const EdgeInsets.all(10),
        ),
      );

  Widget _buildContent() => FutureBuilder<HistoryModel>(
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text("wating..."),
              );
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              return _historyModel.errorCode == 0
                  ? SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Column(
                          children: <Widget>[
                            Text(
                              "${_history.title}",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "${_history.content}",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text("API 调用异常"),
                    );
              break;
            default:
              return Container(color: Colors.grey[200]);
          }
        },
      );

  Future<HistoryModel> fetchDetail() async {
    var model = await HttpImpl.getHistory(widget.param);
    // await Future.delayed(Duration(milliseconds: 1000));
    // var model2 = HistoryModel(historys: [
    //   History(
    //       eId: "11026",
    //       title: "天地会起义，建立大成国",
    //       content: """在160年前的今天，1858年9月27日 (农历八月廿一)，天地会起义，建立大成国。
    // 1858年9月27日（距今160年）（清咸丰五年八月十七日），广东天地去陈开、李文茂等攻克了广西浔州府（今桂平），改浔州为秀州，府城为秀京，国号“大成”，年号洪德。陈开称平浔王，封李文茂为平靖王，梁培友为平东王，梁大昌为定北王。
    // 1858年李文茂攻桂林没有得手，退往黔桂边境，死于怀远山中。
    // 1861年8月，清军攻陷浔州，陈开被执行死刑，余部继续斗争，1864年失败。""")
    // ]);
    print("model======***========>${model.errorCode}");
    setState(() {
      _historyModel = model;
      if (model != null && model.historys.length > 0) {
        _history = model.historys[0];
      }
    });
    return Future<HistoryModel>.value(model);
  }
}
