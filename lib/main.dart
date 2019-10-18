import 'dart:async';

import 'package:book/wanandroid/test_page.dart';
import 'package:book/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'screens.dart';
import 'framework.dart';

/// 当做入口，只提供路由跳转
///
// void main() => runApp(Entrance());
void main() async {
  /// todo 提出去，将一些初始化的操作放到单独类里边
  /// 
  SpUtil.getInstance();

  runZoned(() async => runApp(Entrance()));
}

class Entrance extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: Theme.of(context).copyWith(
          brightness: Brightness.light,
          primaryColor: Styles.colorPrimary,
          cupertinoOverrideTheme: CupertinoTheme.of(context).copyWith(
            brightness: Brightness.light,
            primaryColor: Colors.black, // back icon的颜色等
          ),
          accentColor: Styles.colorPrimary,
          buttonColor: Styles.colorPrimary,
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                textTheme: ButtonTextTheme.primary,
              ),
          cursorColor: Colors.orange,
          textTheme: Theme.of(context).textTheme.copyWith(
                title: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    ),
              ),
          primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
                title: Theme.of(context).primaryTextTheme.title.copyWith(
                      color: Colors.white,
                    ),
              ),
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
                color: Colors.white,
              ),
          scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
          // 设置页面整体背景色
          accentTextTheme: Theme.of(context).accentTextTheme.copyWith(
                button: Theme.of(context).accentTextTheme.button.copyWith(
                      color: Styles.colorPrimary,
                    ),
              ),
          // inputDecorationTheme: const InputDecorationTheme(
          //   focusedBorder: const UnderlineInputBorder(
          //     borderSide: const BorderSide(
          //       color: FmColors.PRIMARY_COLOR,
          //     ),
          //   ),
          // ),
          // appBarTheme: Theme.of(context).appBarTheme.copyWith(
          //   brightness: Brightness.light,
          // ),
        ),
        onGenerateRoute: _onGenerateRoute,
        title: "宴峰",
      );

  Route _onGenerateRoute(RouteSettings settings) {
    print("settings----->$settings");
    if (isEmpty(settings.name)) return null;
    print(
        "settings----->settings.name=${settings.name}   settings.arguments=${settings.arguments}");

    final uri = Uri.parse(settings.name);
    final path = uri.path ?? '';
    final q = uri.queryParameters ?? <String, String>{};
    switch (path) {
      case '/':
      case '/a':
        return _buildRootRoute(settings, (_) => MainPage());
      case '/widgets_for_week':
        return _buildRootRoute(settings, (_) => WidgetsListPage());
      case '/widgets_for_text':
        return _buildRootRoute(settings, (_) => WidgetText());
      case '/detail':
        return _buildRootRoute(
            settings,
            (_) => DetailPage(
                  title: q['title'],
                  url: q["url"],
                ));
      case '/time_movie_detail':
        return _buildRootRoute(
            settings,
            (_) => MovieItemDetailPage(
                  movieId: q['movie_id'],
                ));
      case '/video_play':
        return _buildRootRoute(settings,
            (_) => VideoPlayPage(videoUrl: q['video_url'], title: q['title']));
      case '/image_gallery':
        return _buildRootRoute(
            settings,
            (_) => ImageGalleryPage(
                  images: settings.arguments,
                  position: int.parse(q['position']),
                ));
      case '/gank_list':
        return _buildRootRoute(
            settings,
            (_) => GankCategoryListPage(
                  category: q['category'],
                ));
      case '/collection':
        return _buildRootRoute(settings, (_) => CollectionPage());
      case '/select_city':
        return _buildRootRoute(settings, (_) => SelectCityPage());
        case '/login':
        return _buildRootRoute(settings, (_) => LoginPage());
      case '/test':
        return _buildRootRoute(settings, (_) => TestPage());
      default:
        return null;
    }
  }

  /// 构造一个路由[Route]实例
  Route _buildRoute(RouteSettings settings, WidgetBuilder builder) =>
      MaterialPageRoute<void>(
        settings: settings,
        builder: builder,
      );

  /// 构造一个根页面[_root]路由[Route]实例
  Route _buildRootRoute(RouteSettings settings, WidgetBuilder builder) =>
      _buildRoute(settings, (BuildContext ctx) => _root(ctx, builder(ctx)));

  /// 包装为根页面，pop此页面将关闭flutter页面，返回原生页面
  Widget _root(BuildContext context, Widget child) => WillPopScope(
        child: child,
        onWillPop: () => _onClose(context),
      );

  Future<bool> _onClose(BuildContext context) async {
    debugPrint('page should be closed');
    FocusScope.of(context).requestFocus(FocusNode()); // 确保收起键盘
    // await finishCurrPage(code: AppChannels.RESULT_CANCELLED);
    return true;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
