import 'package:flutter/material.dart';

/// gank 顶部 分类组件
///
class GankCategoryWidget extends StatefulWidget {
  static const category = ["all", "iOS", "拓展资源", "Android", "前端", "福利", "休息视频"];
  @override
  _GankCategoryWidgetState createState() => _GankCategoryWidgetState();
}

class _GankCategoryWidgetState extends State<GankCategoryWidget> {
  void _onCategoryClick(String category) {
    Navigator.pushNamed(context, '/gank_list?category=$category');
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10.0),
        height: 200,
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.green),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/android.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("Android",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick("Android");
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.black87),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/ios.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("iOS",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick("iOS");
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.blue[600]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/chrome.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("前端",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick("前端");
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.orange[600]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/xiaosuolvetu.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("App",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick("all");
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.purple[400]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/icon_movie.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("休息",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick("休息视频");
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.cyan[400]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/book.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("其他",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick('all');
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.deepOrange[500]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/guangpan.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("推荐",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick('all');
                  },
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.pink[200]),
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/icon_image.png',
                          color: Colors.white,
                        ),
                      ),
                      Text("福利",
                          style: TextStyle(color: Colors.black, fontSize: 18.0))
                    ],
                  ),
                  onTap: () {
                    _onCategoryClick('福利');
                  },
                )
              ],
            )
          ],
        ),
      );
}
