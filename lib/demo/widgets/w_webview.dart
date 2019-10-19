import 'dart:convert';

import 'package:book/utils/t.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// - flutter 官方的 webview_flutter 插件的使用，以及与 JS 的数据交互练习
/// - pub 地址 [https://pub.dev/packages/webview_flutter]
///
class WidgetWebview extends StatefulWidget {
  String remoteUrl = "https://www.jianshu.com/p/a110b6a11e2f";
  String localUrl = "assets/html/login.html";
  bool useWebviewFlutter = true; // 是否使用 flutter 提供的插件
  String title;

  @override
  _WidgetWebviewState createState() =>
      useWebviewFlutter ? _WebviewFlutterState() : _FlutterWebViewPluginState();
}

/// 方便将两个插件放在一起对比~
abstract class _WidgetWebviewState extends State<WidgetWebview> {}

class _WebviewFlutterState extends _WidgetWebviewState {
  WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    widget.title = "WebViewFlutter 与 JS 交互";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _loadHtmlFile(),
        builder: (context, snapshot) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: Uri.dataFromString(snapshot.data,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString(),
            javascriptChannels: [_toastJsChannel(context)].toSet(),
            onWebViewCreated: (WebViewController controller) {
              print("webview page: webview created...");
              _webViewController = controller;
              _webViewController.loadUrl(new Uri.dataFromString(snapshot.data,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString());
            },
            onPageFinished: (url) {
              print("webview page: load finished...url=$url");
              _getTitle();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _webViewController.evaluateJavascript("flutterCallJsMethod('message from Flutter!')");
        },
      ),
    );
  }

  // 创建 JavascriptChannel
  JavascriptChannel _toastJsChannel(BuildContext context) => JavascriptChannel(
      name: 'show_flutter_toast',
      onMessageReceived: (JavascriptMessage message) {
        print("get message from JS, message is: ${message.message}");
        T.show(message.message);
      });

  /// 获取当前加载页面的 title
  _getTitle() async {
    String title = await _webViewController.getTitle();
    setState(() {
      widget.title = title;
    });
    print("title---$title");
  }

  /// 加载本地 HTML 文件
  Future<String> _loadHtmlFile() async {
    return await rootBundle.loadString(widget.localUrl);
  }
}

class _FlutterWebViewPluginState extends _WidgetWebviewState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterWebViewPlugin 与 JS 交互"),
      ),
    );
  }
}

class _WidgetWebviewStates extends State<WidgetWebview> {
  WebViewController _webViewController;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = true;
  bool useWebviewFlutter = false;

  _loadHtmlFromAssets() async {
    String url = await rootBundle.loadString(widget.localUrl);
    _webViewController.loadUrl(Uri.dataFromString(url,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

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
  Widget build(BuildContext context) =>
      useWebviewFlutter ? _buildWebviewFlutter() : _buildWebviewPlugin();

  Widget _buildWebviewFlutter() => Scaffold(
        appBar: AppBar(
          title: Text("WebviewFlutter 与 JS"),
        ),
        body: WebView(
          initialUrl: widget.localUrl,
          onWebViewCreated: (controller) {
            _webViewController = controller;
            // _loadHtmlFromAssets();
          },
        ),
      );

  Widget _buildWebviewPlugin() => WebviewScaffold(
        appBar: AppBar(
          title: Text("WebView 与 JS 交互"),
        ),
        url: widget.remoteUrl,
      );
}
