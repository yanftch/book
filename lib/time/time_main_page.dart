import 'package:book/time/time_net_util.dart';
import 'package:flutter/material.dart';
import 'package:book/domins.dart';
import 'package:book/styles.dart' show Styles;
import 'package:cached_network_image/cached_network_image.dart';

/// 时光网主页
///
class TimeMainPage extends StatefulWidget {
  @override
  _TimeMainPageState createState() => new _TimeMainPageState();
}

class _TimeMainPageState extends State<TimeMainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  /// 标记是否正在加载中
  bool isLoading = false;
  List<Movie> movies = [];
  List<Movie> comingMovies = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchComingData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: isLoading ? _loadingWidget() : _buildBody(),
      );

  Widget _loadingWidget() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildBody() => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text("时光"),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "即将上映",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                  Text(
                    "${comingMovies.length}部>",
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              width: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _buildHorizontal(context, index, comingMovies[index]);
                },
                itemCount: comingMovies.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "正在热映",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          _buildContent()
        ],
      );

  Widget _buildHorizontal(BuildContext context, int index, Movie movie) =>
      GestureDetector(
        child: Card(
          child: Container(
            height: 180,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: CachedNetworkImage(
                        imageUrl: movie.img,
                        width: 80,
                        height: 120,
                        placeholder: (context, url) => Container(
                          child: Image.asset("assets/placeholder.png"),
                        ),
                      ),
                      width: 80,
                      height: 120,
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Styles.color_DEE4E4),
                      child: Text(
                        movie.titleCn,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 14.0),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6.0),
                Text(
                  "${movie.wantedCount} 人想看",
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
              context, "/time_movie_detail?movie_id=${movie.movieId}");
        },
      );

  Widget _buildContent() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => _buildCardItem(movies[index]),
          childCount: movies.length),
    );
  }

  Widget _buildCardItem(Movie movie) => GestureDetector(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: movie.img,
                        width: 80,
                        fit: BoxFit.fill,
                        height: 120,
                        placeholder: (context, url) => Container(
                          child: Image.asset("assets/placeholder.png"),
                        ),
                      ),
                      movie.isHot
                          ? Container(
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Hot".toUpperCase(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w800),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[300]),
                            )
                          : SizedBox()
                    ],
                  ),
                  width: 80,
                  height: 120,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildTitleWidget(movie),
                    SizedBox(height: 8.0),
                    _buildDescLine(movie),
                    SizedBox(height: 8.0),
                    Text(
                      (movie.actorName2.isNotEmpty &&
                              movie.actorName1.isNotEmpty)
                          ? "${movie.actorName1} / ${movie.actorName2}"
                          : "",
                      style: Styles.subtitleStyle,
                    ),
                    SizedBox(height: 8.0),
                    movie.showRatings()
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "${movie.ratingFinal}",
                                  style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "分",
                                  style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 16.0)),
                            ]),
                          )
                        : SizedBox()
                  ],
                )),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
              context, "/time_movie_detail?movie_id=${movie.movieId}");
        },
      );

  Widget _buildDescLine(Movie movie) => movie.showRatings()
      ? Text(
          movie.commonSpecial,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.lightGreen),
        )
      : RichText(
          text: TextSpan(style: TextStyle(fontSize: 16.0), children: [
            TextSpan(
                text: "${movie.wantedCount}",
                style: TextStyle(color: Styles.color_E9A445)),
            TextSpan(
                text: "人想看-", style: TextStyle(color: Styles.color_666666)),
            TextSpan(
                text: "${movie.type}",
                style: TextStyle(color: Styles.color_666666)),
          ]),
        );

  Widget _buildTitleWidget(Movie movie) => Row(
        children: <Widget>[
          Text(
            movie.titleCn,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: Styles.titleStyle,
          ),
          SizedBox(width: 4.0),
          // 标签
          movie.is3D
              ? Container(
                  child: Text(
                    "3D",
                    style: Styles.subtitleStyle,
                  ),
                  padding: const EdgeInsets.all(1.0),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                )
              : SizedBox(),
          SizedBox(
            width: 4.0,
          ),
          movie.isIMAX
              ? Container(
                  child: Text(
                    "IMAX",
                    style: Styles.subtitleStyle,
                  ),
                  padding: const EdgeInsets.all(1.0),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                )
              : SizedBox(),
        ],
      );

  void fetchData() {
    TimeNetUtil().getHotMovies((HotModel hotModel) {
      print("count===>${hotModel.count}");
      setState(() {
        isLoading = false;
        movies.clear();
        movies.addAll(hotModel.movies);
      });
    });
  }

  void fetchNowShowingData() {
    TimeNetUtil().getNowShowingMovies((NowShowingMovieModel model) {
      print("model.ms.length========>${model.ms.length}");
      setState(() {
        isLoading = false;
        movies.clear();
        movies.addAll(model.ms);
      });
    });
  }

  void fetchComingData() {
    TimeNetUtil().getComingMovies((ComingMovies model) {
      setState(() {
        print("model.moviecomings.length------->${model.moviecomings.length}");
        isLoading = false;
        comingMovies.clear();
        comingMovies.addAll(model.moviecomings);
      });
    });
  }
}
