import 'dart:ui';
import 'package:flutter/material.dart';

abstract class Styles {
  static const Color color_ff0000 = Color(0xFFFF0000);
  static const Color color_ffffff = Color(0xFFFFFFFF);
  static const Color colorPrimary = Colors.orange;
  static const Color scaffoldBackgroundColor = Color(0xFFF5F5F5);

  /// 标题颜色
  static const Color titleColor = Color(0xFF191919);

  static const Color color_666666 = Color(0xFF666666);
  static const Color color_E9A445 = Color(0xFFE9A445);
  static const Color color_DEE4E4 = Color(0xFFDEE4E4);

  /// 副标题 & 其他文本颜色
  static const Color subTitleColor = Color(0xFF999999);
  static const Color greyCColor = const Color(0xFFCCCCCC);
  static const Color grey3Color = const Color(0xFF333333);
  static const Color grey6Color = const Color(0xFF666666);
  static const Color grey9Color = const Color(0xFF999999);

  /// 常用 TextStyle
  static const TextStyle titleStyle =
      const TextStyle(color: titleColor, fontSize: 16);
  static const TextStyle subtitleStyle =
      const TextStyle(color: subTitleColor, fontSize: 14);
  static TextStyle textDark14 =
      const TextStyle(fontSize: 14, color: grey3Color);
  static TextStyle textGreyC14 =
      const TextStyle(fontSize: 14, color: greyCColor);
      static TextStyle textBlue16 =
      const TextStyle(fontSize:  16, color: Colors.blueAccent);
  static TextStyle textBoldDark26 = const TextStyle(
      fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold);
      static TextStyle textGrey14 =
      const TextStyle(fontSize:  14, color: Colors.grey);

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
