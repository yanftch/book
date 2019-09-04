import 'dart:ui';
import 'package:flutter/material.dart';

abstract class Styles {
  static const Color color_ff0000 = Color(0xFFFF0000);
  static const Color color_ffffff = Color(0xFFFFFFFF);
  static const Color colorPrimary = Colors.orange;

  /// TextStyle

  static const TextStyle SubtitleStyle = const TextStyle(color: color_ff0000);
  static const TextStyle whiteStyle = const TextStyle(color: color_ffffff);

  static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientEnd = const Color(0xFFf7418c);

  /**
   * 渐变的背景色
   */
  static const LinearGradient linearGradient = const LinearGradient(
      colors: const [loginGradientStart, loginGradientEnd],
      stops: const [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
