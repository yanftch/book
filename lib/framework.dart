library framework;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
export 'styles.dart';

bool _isDebugMode; // 记录当前是否debug模式

/// 判断当前是否为Debug模式.
///
/// 参考[Check if running app is in Debug mode](https://stackoverflow.com/q/49707028/679563)
bool get isDebugMode {
  if (_isDebugMode == null) {
    _isDebugMode = false;
    assert(_isDebugMode = true);
  }
  return _isDebugMode;
}

final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;

bool notNull(o) => o != null;
bool isEmpty(String str) => str == null || str.isEmpty;
bool isNotEmpty(String str) => str != null && str.isNotEmpty;
T orNull<T>() => null;

/// 在[list]中查找符合条件的第一个元素，没有找到则返回null，不抛出异常
E firstWhereOrNull<E>(Iterable<E> list, bool test(E element)) =>
  list == null || list.isEmpty ? null : list.firstWhere(test, orElse: orNull);

/// 根据平台按需使用全大写风格
String platformUppercase(String text) => isAndroid ? (text ?? "").toUpperCase() : text;

/// 不做任何事情的[debugPrint]函数，用于release mode，不打印任何信息
void dummyDebugPrint(String message, { int wrapWidth }) {}

Type typeOf<T>() => T;  // https://github.com/dart-lang/sdk/issues/33297
