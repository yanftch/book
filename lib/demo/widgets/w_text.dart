import 'package:flutter/material.dart';

/// widget for [Text]
/// source code: 1.7.8
/// date: 2019/9/7
/// author: yanftch

class WidgetText extends StatefulWidget {
  var richTextStr = "Hot距离放假还有 N 个工作日";

  @override
  _WidgetTextState createState() => new _WidgetTextState();
}

class _WidgetTextState extends State<WidgetText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: _buildTex(),
    );
  }

  Widget _buildTex() => Center(
        child: Column(
          children: <Widget>[
            Text("Text添加下划线",
                style: TextStyle(decoration: TextDecoration.underline)),
            Text("Text添加中划线",
                style: TextStyle(decoration: TextDecoration.lineThrough)),
            Text("Text添加红色中划线",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red)),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text("Text 通过 Container 设置 shape 样式"),
            ),
            SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green, Colors.red]),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text("Text 通过 Container 设置 渐变色 shape 样式"),
            ),
            SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Colors.red, width: 3))),
              child: Text(
                "Text 通过 Container 设置 渐变色 shape 样式",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                  text: "从前有座山,",
                  style: TextStyle(color: Colors.green),
                  children: <TextSpan>[
                    TextSpan(
                        text: "山里有座庙,",
                        style: TextStyle(
                            backgroundColor: Colors.green,
                            color: Colors.white)),
                    TextSpan(
                        text: "庙里有个老和尚.", style: TextStyle(color: Colors.red)),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: "",
                  style: TextStyle(color: Colors.green),
                  children: <TextSpan>[
                    TextSpan(
                        text: widget.richTextStr.substring(0, 3),
                        style: TextStyle(
                            backgroundColor: Colors.green,
                            color: Colors.white)),
                    TextSpan(
                        text: widget.richTextStr
                            .substring(3, widget.richTextStr.length),
                        style: TextStyle(color: Colors.red)),
                  ]),
            ),
            SizedBox(height: 4),
            SizedBox(height: 4),
            SizedBox(height: 4),
            SizedBox(height: 4),
          ],
        ),
      );

  Widget _buildContent() => Container(
        child: Column(
          children: <Widget>[
            Text("Hello World!"),
            Text(
              "红色",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "红色+加粗",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              "红色+斜体",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "红色和黄色背景背景",
              style:
                  TextStyle(color: Colors.red, backgroundColor: Colors.orange),
            ),
            Text(
              "红色和灰色阴影",
              style: TextStyle(
                  color: Colors.red,
                  shadows: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
            ),
            Text(
              "文字带中划线,线的颜色跟随文本颜色",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            Text(
              "文字带下划线",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            Text(
              "文字虚线划线",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            Text(
              "文字双下划线",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double),
            ),
            Text(
              "我超过了屏幕横向宽度，默认值，所以会自动换行。--撑场面的文字-->我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置",
            ),
            Text(
              "我超过了屏幕横向宽度，设置：[overflow]。显示省略号。--撑场面的文字-->我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置",
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "我超过了屏幕横向宽度，设置：[softWrap: false]。单行显示。--撑场面的文字-->我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置我是默认设置",
              softWrap: false,
            ),
            Text(
              "Text不支持设置 shape，需要通过容器来处理",
            ),
            Text("我是默认设置"),
            Text("我是默认设置"),
          ],
        ),
      );
}
