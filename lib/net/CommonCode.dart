import 'package:event_bus/event_bus.dart';

class CommonCode {
  static const HTTP_CODE_404 = 404;

  ///网络错误
  static const NETWORK_ERROR = 10001;

  ///网络超时
  static const NETWORK_TIMEOUT = 10002;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = new EventBus();

//  static errorHandleFunction(code, message, noTip) {
//    if (noTip) {
//      return message;
//    }
//    eventBus.fire(new YYResultErrorEvent(code, message));
//    return message;
//  }
}
