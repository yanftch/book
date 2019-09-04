import 'package:book/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

import 'framework.dart';

/// 当做入口，只提供路由跳转
///
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
                color: Colors.black,
              ),
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
      );

  Route _onGenerateRoute(RouteSettings settings) {
    print("settings----->$settings");
    if (isEmpty(settings.name)) return null;
    print(
        "settings----->settings.name=${settings.name}&&&&settings.arguments=${settings.arguments}");

    final uri = Uri.parse(settings.name);
    final path = uri.path ?? '';
    final q = uri.queryParameters ?? <String, String>{};
    switch (path) {
      case '/':
      case '/a':
        return _buildRootRoute(settings, (_) => MainPage());
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
    return false;
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
