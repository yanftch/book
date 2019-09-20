import 'package:flutter/material.dart';
import 'package:book/domins.dart';

/// 更多信息页面
///
class MoreDetailPage extends StatefulWidget {
  final BoxOffice boxOffice;
  final Movie movie;

  MoreDetailPage(this.boxOffice, this.movie);

  @override
  _MoreDetailPageState createState() => _MoreDetailPageState();
}

class _MoreDetailPageState extends State<MoreDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("${widget.movie.img}"), fit: BoxFit.fill)),
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${widget.boxOffice.ranking}",
                    style: TextStyle(fontSize: 32.0, color: Colors.blue[400])),
                SizedBox(height: 10),
                Text(
                  "今日票房排名",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
              ],
            ),
            Container(
              width: 1,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${widget.boxOffice.totalBoxDes}",
                    style: TextStyle(fontSize: 32.0, color: Colors.blue[400])),
                SizedBox(height: 10),
                Text("${widget.boxOffice.todayBoxDesUnit}",
                    style: TextStyle(fontSize: 18.0, color: Colors.black54)),
              ],
            ),
            Container(
              width: 1,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${widget.boxOffice.totalBoxDes}",
                    style: TextStyle(fontSize: 32.0, color: Colors.blue[400])),
                SizedBox(height: 10),
                Text("${widget.boxOffice.totalBoxUnit}",
                    style: TextStyle(fontSize: 18.0, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
