import 'package:book/utils/collection_utils.dart';
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
  bool hasLiked = false;

  void _checkLiked() async {
    bool liked = await CollectionUtils.hasCollected(widget.url);
    print("是否已经收藏。。。。。。。。。。$liked");
    setState(() {
      hasLiked = liked;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLiked();

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
            child: Icon(
              Icons.favorite,
              color: hasLiked ? Colors.red : Colors.white,
            ),
            onTap: () {
              if (hasLiked) {
                CollectionUtils.unCollect(
                    url: widget.url,
                    title: widget.title,
                    type: "study",
                    movieId: -1);
              } else {
                CollectionUtils.collect(
                    url: widget.url,
                    title: widget.title,
                    type: "study",
                    movieId: -1);
              }
              setState(() {
                hasLiked = !hasLiked;
              });
            },
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
