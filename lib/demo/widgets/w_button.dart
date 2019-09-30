import 'package:book/framework.dart';
import 'package:flutter/material.dart';

/// widget for [MaterialButton]
/// source code: 1.10.2
/// date: 2019/9/30
/// author: yanftch

class WidgetButton extends StatefulWidget {
  @override
  _WidgetButtonState createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) => _buttons();

  Widget _buttons() => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: <Widget>[
            MaterialButton(
                onPressed: () {
                  print("MaterialButton...click");
                },
                child: Text("MaterialButton"),
                textColor: Colors.black,
                color: Colors.grey[100],
                elevation: 10,
                // splashColor: Colors.yellow,
                highlightColor: Colors.pink
                // disabledColor: Colors.blue,
                ),
            FlatButton(
              onPressed: () {
                _showSnackBar("FlatButton无背景色");
              },
              textColor: Colors.black87,
              splashColor: Colors.transparent,
              child: Text("FlatButton Default"),
            ),
            RaisedButton(
              onPressed: () {
                _showSnackBar("RaisedButton 默认");
              },
              child: Text("RaisedButton"),
            ),
            RaisedButton(
              onPressed: () {
                _showSnackBar("RaisedButton 设置内边距20");
              },
              child: Text("RaisedButton 设置内边距20"),
              padding: const EdgeInsets.all(20),
            ),
            SizedBox(width: 10),
            RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "RaisedButton 圆角背景(小)",
                style: TextStyle(fontSize: 10),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(300)),
              ),
              child: Text(
                "RaisedButton 圆角背景(iOS 样式)",
                style: TextStyle(fontSize: 10),
              ),
            ),
            RaisedButton(
              color: Colors.pink[300],
              onPressed: () {},
              textColor: Colors.white,
              padding: const EdgeInsets.all(20),
              shape: CircleBorder(),
              child: Text(
                "圆形样式",
                style: TextStyle(fontSize: 10),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              shape: StadiumBorder(),
              child: Text(
                "StadiumBorder 两头半圆",
                style: TextStyle(fontSize: 10),
              ),
            ),
            SizedBox(width: 10),
            RaisedButton(
              color: Colors.red,
              onPressed: () {},
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "StadiumBorder 两头半圆",
                style: TextStyle(fontSize: 10),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red, width: 1)),
              child: Text("RaisedButton"),
            ),
            SizedBox(width: 10),
            RaisedButton(
              onPressed: () {},
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red, width: 4)),
              child: Text("RaisedButton"),
            ),
            SizedBox(width: 10),
            Theme(
              child: RaisedButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.red, width: 4)),
                child: Text("去掉默认宽高"),
              ),
              data: ThemeData().copyWith(
                  buttonTheme: ButtonThemeData(minWidth: 10, height: 20)),
            ),
            Theme(
              child: RaisedButton(
                onPressed: () {},
                elevation: 0.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Text("渐变背景😍"),
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          LinearGradient(colors: [Colors.green, Colors.red])),
                ),
              ),
              data: ThemeData().copyWith(
                  buttonTheme:
                      ButtonThemeData(padding: const EdgeInsets.all(0))),
            ),
            SizedBox(width: 10),
            OutlineButton(
              onPressed: () {},
              child: Text("自带外边框"),
            ),
            SizedBox(width: 10),
            RaisedButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.add), Text("带图标")],
              ),
            ),
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      );

  void _showSnackBar(String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
