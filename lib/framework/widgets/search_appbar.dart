import 'package:flutter/material.dart';

import 'helper.dart';
typedef onCompleteEvent<T> = void Function(T value);
/// 自定义带有搜索输入框的 AppBar
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// 返回键图标
  final Widget leading;

  /// 高度
  final double height;

  /// 默认提示文案
  final String placeholder;

  /// Controller
  final TextEditingController controller;

  /// 回调监听
  final VoidCallback onEditComplete;

  /// 输入完成回调
  final onCompleteEvent onComplete;


  const SearchAppBar({
    Key key,
    this.leading,
    this.height: 60.0,
    this.placeholder: "placeholder...",
    this.controller,
    this.onEditComplete,
    this.onComplete,
  }) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  /// 此方法控制了AppBar 的高度
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(widget.height),
        child: Stack(
          children: <Widget>[
            Offstage(
              child: PreferredSize(
                  child: AppBar(),
                  preferredSize: Size.fromHeight(widget.height)),
              offstage: false,
            ),
            Offstage(
              offstage: false,
              child: Container(
                padding: const EdgeInsets.only(left: 50.0, bottom: 10),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(color: Colors.grey[300], fontSize: 18),
                    hintMaxLines: 1,
                  ),
                  onSubmitted: (v) => widget.onComplete(v),
                  onEditingComplete: widget.onEditComplete,
                ),
              ),
            )
          ],
        ),
      );
}
