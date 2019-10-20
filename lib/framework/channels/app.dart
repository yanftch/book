import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/services.dart' show MethodChannel, EventChannel;
import 'package:flutter/widgets.dart' show ScrollPosition;
import 'package:meta/meta.dart' show required;

import '../consts.dart';

/// 提供与Native层通信的方法.
///
/// TODO 由于数据涉及到App层面的东西，简化起见，虽然[AppChannels]定义在framework模块，
/// 但原生层是在App层面实现的，并非由framework模块独立提供，后续想办法拆分
mixin AppChannels {
  static const RESULT_OK = 0;
  static const RESULT_CANCELLED = 1;

  static const _M_OPEN_PAGE = 'open';
  static const _M_NATIVE_SHARE = 'share';
  static const _M_SHOW_TOAST = 'toast';
  static const _M_FINISH_PAGE = 'finish';
  static const _M_GET_SESSION = 'session';
  static const _M_SIGN = 'sign';
  static const _M_TRACK_EVENT = 'trackEvent';
  static const _M_SHARE = "share";
  static const _M_GET_CONFIG = "config";
  static const _M_BROADCAST = "broadcast";
  static const _M_AD_ID = "ad_id";

  /// 原生App通信通道
  static const _appChannel = const MethodChannel('book/app');

  /// 原生App Streaming事件通道
  static const appEvents = const EventChannel('fivemiles/events');

  /// 打开指定的原生App页面.
  ///
  /// - [url] 目标页面，以URL或字符串表达，建议使用URL格式(deeplink)
  /// - [isPresenting] 页面打开的方式为`true`则从下往上弹出，暂时只有iOS支持
  /// - [args] 需要传递的参数, 可选
  ///
  /// @returns 可能返回该页面的运行结果
  Future<dynamic> openAppPage({
    @required String url,
    bool isPresenting,
    Map<String, dynamic> args,
  }) =>
      _appChannel.invokeMethod(_M_OPEN_PAGE, <String, dynamic>{
        'url': url,
        'args': args,
        if (isPresenting == true) 'present': isPresenting,
      });

  /// 调用原生分享
  Future<dynamic> nativeShare(
          {@required String message, Map<String, dynamic> args}) =>
      _appChannel.invokeMethod(
          _M_NATIVE_SHARE, <String, dynamic>{'content': message, 'args': args});

  Future<dynamic> showNativeToast(
          {@required String message, Map<String, dynamic> args}) =>
      _appChannel.invokeMethod(
          _M_SHOW_TOAST, <String, dynamic>{'message': message, 'args': args});

  /// 使用原生新窗口打开另一个flutter页面, 使用通用的deeplink: `fivemiles://flt`
  Future<dynamic> newFlutterWindow(
    String route, {
    bool isPresenting,
    Map<String, dynamic> args,
  }) =>
      openAppPage(
        url: "fivemiles://flt?url=${Uri.encodeComponent(route)}",
        isPresenting: isPresenting,
        args: args,
      );

  /// 关闭当前页面(即退出当前Flutter app), 并可向native层传递数据.
  ///
  /// - [code] 执行结果代码, 见 [RESULT_OK], [RESULT_CANCELLED]
  /// - [data] 待传递的数据, 可选
  Future<void> finishCurrPage({
    int code = RESULT_CANCELLED,
    Map<String, dynamic> data,
  }) =>
      _appChannel.invokeMethod(_M_FINISH_PAGE, <String, dynamic>{
        'code': code,
        'data': data,
      });

  /// 通过 key 获取用户本地存储的(JSON String).
  Future<String> getConfigs({String key}) =>
      _appChannel.invokeMethod(_M_GET_CONFIG, key).then((json) => json);

  /// 获取指定广告位[adSlotKey]的广告id
  Future<String> getAdId(String adSlotKey) => _appChannel
      .invokeMethod(_M_AD_ID, adSlotKey)
      .then((id) => id?.toString() ?? "");

  Future<void> requestShare(String templateName, String fullUrl, String type,
          String objectId, String objectTitle, Map<String, dynamic> data) =>
      _appChannel.invokeMethod(_M_SHARE, <String, dynamic>{
        'templateName': templateName,
        'fullUrl': fullUrl,
        'type': type,
        'objectId': objectId,
        'objectTitle': objectTitle,
        'data': data,
      });

  /// 向原生层发送广播消息, [code]为唯一标示, 可携带附加数据[data]
  Future<void> broadcast(
    FmMsgCode code, [
    Map<String, dynamic> data,
  ]) =>
      _appChannel.invokeMethod(_M_BROADCAST, <String, dynamic>{
        'code': code.index,
        'data': data,
      }).catchError((e) => debugPrint("broadcast failed: $e"));

  /// 向原生层发送`onScroll`事件
  Future<void> broadcastOnScroll(ScrollPosition position) {
    final data = <String, dynamic>{
      "pixels": position.pixels,
      "maxScrollExtent": position.maxScrollExtent,
    };

    // if (isAndroid) {
    //   // Android平台按app的定义换算具体消息码
    //   final y = position.pixels.toInt();
    //   final direction = position.userScrollDirection;
    //   int what;
    //   if (y == 0) {
    //     what = MSG_ANDROID_AT_TOP;
    //   } else if (direction == ScrollDirection.forward) {
    //     what = MSG_ANDROID_SCROLL_UP;
    //   } else if (direction == ScrollDirection.reverse) {
    //     what = MSG_ANDROID_SCROLL_DOWN;
    //   }

    //   data["what"] = what;
    // }

    return broadcast(FmMsgCode.onScroll, data);
  }
}
