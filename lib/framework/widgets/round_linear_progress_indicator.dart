import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

const double _kLinearProgressIndicatorHeight = 6.0;
const int _kIndeterminateLinearDuration = 1800;
//const List<Color> _defaultGradientColors = [
//  Color.fromARGB(255, 255, 102, 102),
//  Color.fromARGB(255, 240, 46, 46)
//];

/// 支持圆角&渐变色的 LinearProgressIndicator
/// [gradientColors] 渐变色数组
class RoundLinearProgressIndicator extends ProgressIndicator {

  /// 默认的灰色渐变色数组
  static const List<Color> defaultGreyColors = [
    Color.fromARGB(255, 199, 199, 199),
    Color.fromARGB(255, 199, 199, 199),
  ];

  /// 默认的红色渐变色数组
  static const List<Color> defaultGradientColors = [
    Color.fromARGB(255, 255, 102, 102),
    Color.fromARGB(255, 240, 46, 46),
  ];

  /// 如若显示固定色，给 [gradientColors] 设置同色值数组 eg.[Colors.red, Colors.red]
  const RoundLinearProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
    String semanticsLabel,
    String semanticsValue,
    this.gradientColors,
  }) : super(
    key: key,
    value: value,
    backgroundColor: backgroundColor,
    valueColor: valueColor,
    semanticsLabel: semanticsLabel,
    semanticsValue: semanticsValue,
  );
  final List<Color> gradientColors;

  @override
  _RoundLinearProgressIndicatorState createState() =>
    _RoundLinearProgressIndicatorState();

  Color _getBackgroundColor(BuildContext context) =>
    backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getValueColor(BuildContext context) =>
    valueColor?.value ?? Theme.of(context).accentColor;

  /// 如果输入的数组为空或者数组中只有一个颜色，那么就采用默认值[_defaultGradientColors]
  List<Color> _getColors() {
    if (gradientColors == null || gradientColors.isEmpty || gradientColors.length == 1) {
      return defaultGradientColors;
    } else {
      return gradientColors.sublist(0, 2);
    }
  }

  Widget _buildSemanticsWrapper({
    @required BuildContext context,
    @required Widget child,
  }) {
    String expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}

class _RoundLinearProgressIndicatorState
  extends State<RoundLinearProgressIndicator>
  with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  double currentPercent; /// 记录 Animation 的值

  @override
  void initState() {
    super.initState();
    currentPercent = widget.value; /// 保存 value 的备份
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    )..addListener((){
      setState(() {
        currentPercent  = _animation.value;
      });
    })
      ..addStatusListener((status){

      });

    _animation = Tween(begin: 0.0, end: widget.value).animate(_controller);
    _controller.forward();

    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(RoundLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentPercent = widget.value;

    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, double animationValue,
    TextDirection textDirection) {
    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: _kLinearProgressIndicatorHeight,
        ),
        child: CustomPaint(
          painter: _LinearProgressIndicatorPainter(
            backgroundColor: widget._getBackgroundColor(context),
            valueColor: widget._getValueColor(context),
            value: currentPercent,
            // may be null
            animationValue: animationValue,
            // ignored if widget.value is not null
            textDirection: textDirection,
            gradientColors: widget._getColors(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
//    _controller.forward();


    if (widget.value != null)
      return _buildIndicator(context, _controller.value, textDirection);

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(context, _controller.value, textDirection);
      },
    );
  }
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  const _LinearProgressIndicatorPainter({
    this.backgroundColor,
    this.valueColor,
    this.value,
    this.animationValue,
    @required this.textDirection,
    this.gradientColors,
  }) : assert(textDirection != null);

  final Color backgroundColor;
  final Color valueColor;
  final double value;
  final double animationValue;
  final TextDirection textDirection;
  final List<Color> gradientColors;

  // The indeterminate progress animation displays two lines whose leading (head)
  // and trailing (tail) endpoints are defined by the following four curves.
  static const Curve line1Head = Interval(
    0.0,
    750.0 / _kIndeterminateLinearDuration,
    curve: Cubic(0.2, 0.0, 0.8, 1.0),
  );
  static const Curve line1Tail = Interval(
    333.0 / _kIndeterminateLinearDuration,
    (333.0 + 750.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static const Curve line2Head = Interval(
    1000.0 / _kIndeterminateLinearDuration,
    (1000.0 + 567.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.0, 0.0, 0.65, 1.0),
  );
  static const Curve line2Tail = Interval(
    1267.0 / _kIndeterminateLinearDuration,
    (1267.0 + 533.0) / _kIndeterminateLinearDuration,
    curve: Cubic(0.10, 0.0, 0.45, 1.0),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.fill;

    /// 绘制下层背景色
    Radius radius = Radius.circular(20.0);
    RRect rRect = RRect.fromRectAndRadius(Offset.zero & size, radius);
    canvas.drawRRect(rRect, paint);

    paint.color = valueColor;

    /// 上层进度条绘制
    void drawBar(double x, double width) {
      if (width <= 0.0) return;

      double left;
      switch (textDirection) {
        case TextDirection.rtl:
          left = size.width - width - x;
          break;
        case TextDirection.ltr:
          left = x;
          break;
      }

      ///绘制上层
      Radius radius = Radius.circular(20.0);
      Rect rect = Offset(left, 0.0) & Size(width, size.height);
      RRect rRect = RRect.fromRectAndRadius(rect, radius);

      LinearGradient linearGradient = LinearGradient(colors: gradientColors);
      //print("debug_______drawBar.......$linearGradient");
      paint.shader = linearGradient.createShader(rect);
      canvas.drawRRect(rRect, paint);
    }

    if (value != null) {
      drawBar(0.0, value.clamp(0.0, 1.0) * size.width);
    } else {
      final double x1 = size.width * line1Tail.transform(animationValue);
      final double width1 =
        size.width * line1Head.transform(animationValue) - x1;

      final double x2 = size.width * line2Tail.transform(animationValue);
      final double width2 =
        size.width * line2Head.transform(animationValue) - x2;

      drawBar(x1, width1);
      drawBar(x2, width2);
    }
  }

  @override
  bool shouldRepaint(_LinearProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
      oldPainter.valueColor != valueColor ||
      oldPainter.value != value ||
      oldPainter.animationValue != animationValue ||
      oldPainter.textDirection != textDirection;
  }
}
