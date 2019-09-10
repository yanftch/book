import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// 详情页，web 页
/// [title] 页面标题
/// [url] URL
///
class DetailPage extends StatefulWidget {
  final String title;
  final String url;

  DetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      debugPrint('state:_' + state.type.toString());
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          isLoading = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoading
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.favorite_border),
            onTap: () {},
          ),
          GestureDetector(
            child: Container(
              child: Icon(Icons.apps),
              margin: EdgeInsets.only(right: 10.0, left: 10.0),
            ),
            onTap: () {},
          ),
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
