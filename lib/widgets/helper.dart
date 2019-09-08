import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:book/framework.dart' show isIOS;

/// 返回一个[WidgetBuilder]代理，使得真正的组件得到延迟加载.
///
/// #### Sample code
///
/// ```dart
/// import 'demo.dart' deferred as demo;
///
/// builder: lazyBuilder(loader: () async {
///   await demo.loadLibrary();
///   return demo.Demo();
/// }),
/// ```
WidgetBuilder lazyBuilder<T extends Widget>({
  Future<T> future,
  Future<T> Function() loader,
}) => (BuildContext context) =>
    FutureBuilder<T>(
      future: future ?? loader(),
      builder: (_, snapshot) => snapshot.data ?? SizedBox(),
    );

/// 创建平台特定的`App`实例.
///
/// 详见[MaterialApp], [CupertinoApp]
/// Note: 目前顶层统一使用MaterialApp，否则代码很难重用，比如即使Theme.of都需要区分平台
//Widget platformApp({
//  ThemeData theme,
//  CupertinoThemeData iosTheme,
//  Map<String, WidgetBuilder> routes,
//  RouteFactory onGenerateRoute,
//  RouteFactory onUnknownRoute,
//  List<NavigatorObserver> navigatorObservers,
//  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
//  Iterable<Locale> supportedLocales,
//}) => isIOS ?
//  CupertinoApp(
//    theme: iosTheme,
//    routes: routes,
//    onGenerateRoute: onGenerateRoute,
//    onUnknownRoute: onUnknownRoute,
//    navigatorObservers: navigatorObservers,
//    localizationsDelegates: localizationsDelegates,
//    supportedLocales: supportedLocales,
//  ) : MaterialApp(
//    theme: theme,
//    routes: routes,
//    onGenerateRoute: onGenerateRoute,
//    onUnknownRoute: onUnknownRoute,
//    navigatorObservers: navigatorObservers,
//    localizationsDelegates: localizationsDelegates,
//    supportedLocales: supportedLocales,
//  );

/// 创建平台特定的`Scaffold`实例
///
/// 详见[Scaffold], [CupertinoPageScaffold]
Widget platformScaffold(BuildContext context, {
  Key key,
  PreferredSizeWidget appBar,
  Widget body,
  Widget floatingActionButton,
  FloatingActionButtonLocation floatingActionButtonLocation,
}) => isIOS ?
// 套在MaterialApp中使用时，在iOS文本会变成bold且有双下划线，需要指定DefaultTextStyle
DefaultTextStyle(
    style: CupertinoTheme.of(context).textTheme.textStyle,
    child: CupertinoPageScaffold(
      key: key,
      navigationBar: appBar,
      child: body,
    )) : Scaffold(
  key: key,
  appBar: appBar,
  body: body,
  floatingActionButton: floatingActionButton,
  floatingActionButtonLocation: floatingActionButtonLocation,
);

/// 使用5miles风格back icon的[AppBar]，目前是为了iOS平台自定义[AppBar]的back icon
/// 请根据情况选用[fmAppBar]或[platformAppBar]
Widget fmAppBar(BuildContext context, {
  Key key,
  Widget title,
  Widget trailing,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.maybePop(context),
  ),
  title: title,
  centerTitle: isIOS,
  elevation: isIOS ? 0.5 : null,
);

/// 创建平台特定的`AppBar`或`NavigationBar`实例
///
/// 详见[AppBar], [CupertinoNavigationBar]
Widget platformAppBar({
  Key key,
  Widget leading,
  Widget title,
  Widget trailing,
  List<Widget> actions,
}) => isIOS ?
CupertinoNavigationBar(
  key: key,
  leading: leading,
  middle: title,
  trailing: trailing,
) : AppBar(
  key: key,
  leading: leading,
  title: title,
  actions: actions,
);

/// 创建平台特定的`TextField`实例
///
/// 详见[TextField], [CupertinoTextField]
Widget platformTextField({
  Key key,
  TextEditingController controller,
  FocusNode focusNode,
  BoxDecoration decoration,
  InputDecoration inputDecoration,
  String placeholder,
  TextInputType keyboardType,
  TextInputAction inputAction,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextStyle style,
  TextAlign textAlign = TextAlign.start,
  bool obscureText = false,
  int maxLines = 1,
  int minLines,
  int maxLength,
  ValueChanged<String> onChanged,
  ValueChanged<String> onSubmitted,
  List<TextInputFormatter> inputFormatters,
  bool enabled,
}) => isIOS ?
cupertinoTextField(
  key: key,
  controller: controller,
  focusNode: focusNode,
  decoration: decoration,
  placeholder: placeholder,
  keyboardType: keyboardType,
  textInputAction: inputAction,
  textCapitalization: textCapitalization,
  style: style,
  textAlign: textAlign,
  obscureText: obscureText,
  maxLines: maxLines,
  minLines: minLines,
  maxLength: maxLength,
  onChanged: onChanged,
  onSubmitted: onSubmitted,
  inputFormatters: inputFormatters,
  enabled: enabled,
) : TextField(
  key: key,
  controller: controller,
  focusNode: focusNode,
  decoration: inputDecoration,
  keyboardType: keyboardType,
  textInputAction: inputAction,
  textCapitalization: textCapitalization,
  style: style,
  textAlign: textAlign,
  obscureText: obscureText,
  maxLines: maxLines,
  minLines: minLines,
  maxLength: maxLength,
  onChanged: onChanged,
  onSubmitted: onSubmitted,
  inputFormatters: inputFormatters,
  enabled: enabled,
);

/// 创建平台敏感的`Switch`实例
///
/// 详见[Switch], [CupertinoSwitch]
Widget platformSwitch({
  Key key,
  @required bool value,
  @required ValueChanged<bool> onChanged,
  Color activeColor,
  Color activeTrackColor,
  Color inactiveThumbColor,
  Color inactiveTrackColor,
  ImageProvider activeThumbImage,
  ImageProvider inactiveThumbImage,
  MaterialTapTargetSize materialTapTargetSize,
}) => isIOS ?
CupertinoSwitch(
  key: key,
  value: value,
  onChanged: onChanged,
  activeColor: activeColor,
) : Switch(
  key: key,
  value: value,
  onChanged: onChanged,
  activeColor: activeColor,
  activeTrackColor: activeTrackColor,
  inactiveThumbColor: inactiveThumbColor,
  inactiveTrackColor: inactiveTrackColor,
  activeThumbImage: activeThumbImage,
  inactiveThumbImage: inactiveThumbImage,
  materialTapTargetSize: materialTapTargetSize,
);

/// 创建平台敏感的`Slider`实例
///
/// 详见[Slider], [CupertinoSlider]
Widget platformSlider({
  Key key,
  @required double value,
  @required ValueChanged<double> onChanged,
  ValueChanged<double> onChangeStart,
  ValueChanged<double> onChangeEnd,
  double min = 0.0,
  double max = 1.0,
  int divisions,
  String label,
  Color activeColor,
  Color inactiveColor,
  SemanticFormatterCallback semanticFormatterCallback,
}) => isIOS ?
CupertinoSlider(
  key: key,
  value: value,
  onChanged: onChanged,
  onChangeStart: onChangeStart,
  onChangeEnd: onChangeEnd,
  min: min,
  max: max,
  divisions: divisions,
  activeColor: activeColor,
) : Slider(
  key: key,
  value: value,
  onChanged: onChanged,
  onChangeStart: onChangeStart,
  onChangeEnd: onChangeEnd,
  min: min,
  max: max,
  divisions: divisions,
  label: label,
  activeColor: activeColor,
  inactiveColor: inactiveColor,
  semanticFormatterCallback: semanticFormatterCallback,
);

/// 创建平台特定的`ProgressIndicator`实例.
///
/// 详见[CircularProgressIndicator], [CupertinoActivityIndicator]
Widget platformProgressIndicator({
  Key key,
  double size = 24,
}) => SizedBox(
  width: size,
  height: size,
  child: isIOS ?
  CupertinoActivityIndicator(
    key: key,
  ) : CircularProgressIndicator(
    key: key,
  ),
);

/// 显示上文菜单[items], 菜单项的`value`类型为[T]
///
/// 暂时固定在组件的中间位置弹出
Future<T> showContextMenu<T>(BuildContext context, {
  @required List<PopupMenuEntry<T>> items,
}) {
  final RenderBox cell = context.findRenderObject();
  final RenderBox overlay = Overlay
      .of(context)
      .context
      .findRenderObject();
  return showMenu(
    context: context,
    position: RelativeRect.fromRect(
      // 目前在居中位置显示上下文菜单
      Rect.fromPoints(
        cell.localToGlobal(cell.size.topCenter(Offset(0, 24)), ancestor: overlay),
        cell.localToGlobal(cell.size.bottomCenter(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    ),
    items: items,
  );
}

/// 构建[CupertinoTextField]的方便方法, 可以根据Theme指定[cursorColor].
///
/// [cursorColor]的默认颜色是[CupertinoThemeData.primaryColor], 但与返回箭头颜色冲突, 因此单独处理[cursorColor].
Widget cupertinoTextField({
  Key key,
  TextEditingController controller,
  FocusNode focusNode,
  BoxDecoration decoration,
  String placeholder,
  TextInputType keyboardType,
  TextInputAction textInputAction,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextStyle style,
  TextAlign textAlign = TextAlign.start,
  bool obscureText = false,
  int maxLines = 1,
  int minLines,
  int maxLength,
  ValueChanged<String> onChanged,
  ValueChanged<String> onSubmitted,
  List<TextInputFormatter> inputFormatters,
  bool enabled,
}) => Builder(
  builder: (context) => CupertinoTextField(
    controller: controller,
    focusNode: focusNode,
    decoration: decoration,
    placeholder: placeholder,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    textCapitalization: textCapitalization,
    style: style,
    textAlign: textAlign,
    obscureText: obscureText,
    maxLines: maxLines,
    minLines: minLines,
    maxLength: maxLength,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    inputFormatters: inputFormatters,
    enabled: enabled,
    cursorColor: CupertinoTheme.of(context).brightness == Brightness.light
        ? CupertinoColors.activeBlue
        : CupertinoColors.activeOrange,
  ),
);

/// 构建能够从Theme中继承按钮文本颜色的[FlatButton].
///
/// [textColor]将读取[Theme.textTheme.button.color]的值.
/// see: https://github.com/flutter/flutter/issues/19623
Widget themedFlatButton({
  Key key,
  @required VoidCallback onPressed,
  ValueChanged<bool> onHighlightChanged,
  ButtonTextTheme textTheme,
  Color disabledTextColor,
  Color color,
  Color disabledColor,
  Color focusColor,
  Color hoverColor,
  Color highlightColor,
  Color splashColor,
  Brightness colorBrightness,
  EdgeInsetsGeometry padding,
  ShapeBorder shape,
  Clip clipBehavior,
  FocusNode focusNode,
  MaterialTapTargetSize materialTapTargetSize,
  @required Widget child,
}) => Builder(
  builder: (context) => FlatButton(
    key: key,
    child: child,
    onPressed: onPressed,
    onHighlightChanged: onHighlightChanged,
    textTheme: textTheme,
    textColor: Theme.of(context).textTheme.button.color,
    disabledColor: disabledColor,
    disabledTextColor: disabledTextColor,
    color: color,
    focusColor: focusColor,
    hoverColor: hoverColor,
    highlightColor: highlightColor,
    splashColor: splashColor,
    colorBrightness: colorBrightness,
    padding: padding,
    shape: shape,
    clipBehavior: clipBehavior,
    focusNode: focusNode,
    materialTapTargetSize: materialTapTargetSize,
  ),
);

/// 显示平台特定样式的AlertDialog.
///
/// - 标题和正文分别通过[title], [content]指定, 均为可选
/// - [actionBuilders]用于构建对话框的动作按钮, 没有特殊情况建议使用[themedFlatButton]代替[FlatButton], 以便统一设置按钮文本样式
Future<T> alert<T>(BuildContext context, {
  Widget title,
  Widget content,
  List<WidgetBuilder> actionBuilders,
}) {
  Widget themed(WidgetBuilder builder) => Theme(
    data: Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.copyWith(
        button: Theme.of(context).textTheme.button.copyWith(
          color: isIOS ? CupertinoColors.activeBlue : Theme.of(context).accentColor,
        ),
      ),
    ),
    child: Builder(builder: builder),
  );

  return isIOS ? showCupertinoDialog(context: context, builder: (_) =>
      themed((context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: _buildWidgets(context, actionBuilders),
      )))
      : showDialog(context: context, builder: (_) =>
      themed((context) => AlertDialog(
        title: title,
        content: content,
        actions: _buildWidgets(context, actionBuilders),
      )));
}

List<Widget> _buildWidgets(BuildContext context, List<WidgetBuilder> builders) =>
    (builders ?? []).map((builder) => builder(context)).toList();
