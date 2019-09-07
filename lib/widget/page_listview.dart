import 'package:flutter/material.dart';

/// 支持分页&刷新的 ListView
/// 
/// 

class PagingListView extends StatefulWidget {

  /// Widgets for Header
  final Widget header;

  PagingListView({Key key, this.header});

  
  @override
  _PagingListViewState createState() => _PagingListViewState();
}

class _PagingListViewState<T> extends State<PagingListView> {
  List<T> _list = [];
  int _page = 0; // 分页，默认为 0
  var _haveFooterView = true;



  @override
  Widget build(BuildContext context) {

      /// header + 数组的尺寸 + footer
      // var itemCount = (widget.header == null  ? 0 : 1) + () + ();







    return Container(
      
    );
  }
}