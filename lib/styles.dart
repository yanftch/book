import 'dart:ui';
import 'package:flutter/material.dart';

abstract class Styles {
  static const Color color_ff0000 = Color(0xFFFF0000);
  static const Color color_ffffff = Color(0xFFFFFFFF);
  static const Color colorPrimary = Colors.orange;
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5);

  /// 标题颜色
  static const Color titleColor = Color(0xFF191919);

  /// 副标题 & 其他文本颜色
  static const Color subTitleColor = Color(0xFF999999);


  /// 常用 TextStyle
  static const TextStyle titleStyle = const TextStyle(
      color: titleColor, fontSize: 16);
  static const TextStyle subtitleStyle = const TextStyle(
      color: subTitleColor, fontSize: 14);

  static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientEnd = const Color(0xFFf7418c);

  ///渐变的背景色
  static const LinearGradient linearGradient = const LinearGradient(
      colors: const [loginGradientStart, loginGradientEnd],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const LinearGradient linearGradientCopy = const LinearGradient(
      colors: const [Color(0xFFFF6666), Color(0xFFf02E2E)],
      stops: const [0.0, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);
}
