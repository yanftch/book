import 'package:flutter/material.dart';
import 'package:book/domins.dart' show Movie, Video;

/// 影评简介页面
///
class IntroductionPage extends StatefulWidget {
  final Movie _movie;

  IntroductionPage(@required this._movie);
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildStroy(widget._movie),
            _buildActorsAndStuff(widget._movie),
            _buildTricksView(widget._movie),
            SizedBox(height: 10.0),
            _buildStageView(widget._movie),
          ],
        ),
      );

  Widget _buildStroy(Movie movie) => Container(
        color: Colors.white60,
        padding: const EdgeInsets.all(16.0),
        child: Text("${movie.story}"),
      );

  Widget _buildActorsAndStuff(Movie movie) => Container(
        color: Colors.white24,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("演职人员",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                Text(
                  "全部 >",
                  style: TextStyle(fontSize: 14.0, color: Colors.black38),
                ),
              ],
            ),
            _buildActorView(movie)
          ],
        ),
      );

  Widget _buildActorView(Movie movie) => SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(
                      "${movie.actorsStuffs[index].img}",
                      width: 90,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text("${movie.actorsStuffs[index].name}",
                      style: TextStyle(fontSize: 16.0, color: Colors.black87)),
                  Text("${movie.actorsStuffs[index].nameEn}",
                      style: TextStyle(fontSize: 12.0, color: Colors.black38)),
                  (index > 0)

                      /// 第一个是导演
                      ? Text("饰 ${movie.actorsStuffs[index].roleName}",
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38))
                      : SizedBox(),
                ],
              ),
            );
          },
          itemCount: movie.actorsStuffs.length,
        ),
      );

  /// 花絮&预告
  Widget _buildTricksView(Movie movie) => Container(
        color: Colors.white24,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("花絮",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ],
            ),
            _buildTrickIvView(movie)
          ],
        ),
      );

  /// 剧照
  Widget _buildStageView(Movie movie) => Container(
        color: Colors.white24,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("剧照",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                // Text(
                //   "全部 >",
                //   style: TextStyle(fontSize: 14.0, color: Colors.black38),
                // ),
              ],
            ),
            _buildStageIvView(movie)
          ],
        ),
      );

  /// 剧照
  Widget _buildStageIvView(Movie movie) => SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(4.0),
              child: Image(
                image: NetworkImage("${movie.stageImg.list[index].imgUrl}"),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: movie.actorsStuffs.length,
        ),
      );

  /// 花絮
  Widget _buildTrickIvView(Movie movie) => SizedBox(
      height: 200,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                image: NetworkImage("${movie.video.image}"),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 48,
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
              context, "/video_play?video_url=${movie.video.url}&title=${movie.video.title}");
        },
      ));
}
