import 'package:book/screens.dart';
import 'package:flutter/material.dart';
import 'package:book/time/time_net_util.dart';
import 'package:book/domins.dart';
import 'package:flutter/services.dart';
import 'package:book/screens.dart' show IntroductionPage, MovieCommentsPage;

import '../widgets.dart';

/// 时光网电影详情页
class MovieItemDetailPage extends StatefulWidget {
  /// movieId 唯一标识，作为查询详情页参数
  final String movieId;

  MovieItemDetailPage({this.movieId});
  @override
  _MovieItemDetailPageState createState() => _MovieItemDetailPageState();
}

class _MovieItemDetailPageState extends State<MovieItemDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Movie _movie;
  BoxOffice _boxOffice;

  /// 评论
  List<Comment> _comments;
  //// 花絮
  List<Video> _videos;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchMovieDetail(widget.movieId);
    fetchMovieComments(widget.movieId);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: (_movie == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : NestedScrollView(
                  headerSliverBuilder: (context, index) {
                    return [
                      SliverAppBar(
                        bottom: PreferredSize(
                          preferredSize: Size(double.infinity, 60.0),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black38,
                            indicatorColor: Colors.black54,
                            tabs: <Widget>[
                              Tab(
                                text: "简介",
                              ),
                              Tab(
                                text: "影评",
                              ),
                              Tab(
                                text: "更多",
                              ),
                            ],
                          ),
                        ),
                        title: Text("${_movie.titleCn}"),
                        brightness: Brightness.light,
                        pinned: true,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        expandedHeight: 260,
                        flexibleSpace: FlexibleSpaceBar(
                          background: _buildTabHeader(),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      IntroductionPage(_movie),
                      MovieCommentsPage(_comments),
                      MoreDetailPage(_boxOffice, _movie)
                    ],
                  ),
                )

          // CustomScrollView(
          //     slivers: <Widget>[
          //       SliverAppBar(
          //         title: Text("${_movie.titleCn}"),
          //         brightness: Brightness.light,
          //         pinned: true,
          //         leading: IconButton(
          //           icon: Icon(
          //             Icons.arrow_back_ios,
          //             color: Colors.black54,
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //         ),
          //         expandedHeight: 220,
          //         flexibleSpace: FlexibleSpaceBar(
          //           background: _buildTabHeader(),
          //         ),
          //       ),
          //       SliverPersistentHeader(
          //           pinned: true,
          //           delegate: StickyTabBarDelegate(
          //               child: TabBar(
          //             labelColor: Colors.black,
          //             unselectedLabelColor: Colors.black38,
          //             indicatorColor: Colors.black54,
          //             controller: _tabController,
          //             tabs: <Widget>[
          //               Tab(
          //                 text: "简介",
          //               ),
          //               Tab(
          //                 text: "影评",
          //               )
          //             ],
          //           ))),
          //       SliverFillRemaining(
          //         child: TabBarView(
          //           controller: _tabController,
          //           children: <Widget>[
          //             IntroductionPage(_movie),
          //             MovieCommentsPage(_movie),
          //           ],
          //         ),
          //       )
          //     ],
          //   )
          ,
        ),
      );

  Widget _buildTabHeader() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.network(
                _movie.img,
                fit: BoxFit.fill,
                width: 90,
                height: 120,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(_movie.titleCn,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    Text(_movie.titleEn,
                        style:
                            TextStyle(color: Colors.black87, fontSize: 14.0)),
                    SizedBox(height: 6.0),
                    RichText(
                      maxLines: 2,
                      text: TextSpan(
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black45),
                          children: [
                            TextSpan(text: "${_movie.type} · "),
                            TextSpan(text: "${_movie.mins} · "),
                            TextSpan(text: "${_movie.releaseDate}"),
                          ]),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      "${_movie.commonSpecial}",
                      style: TextStyle(fontSize: 18.0, color: Colors.black87),
                    )
                  ],
                ),
              )
            ],
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "评分 ",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue[300],
                      fontWeight: FontWeight.w500)),
              TextSpan(
                  text: "${_movie.ratingFinal}",
                  style: TextStyle(
                      fontSize: 32.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue[500],
                      fontWeight: FontWeight.w800))
            ]),
          ),
        ],
      ));

  void fetchMovieDetail(String movieId) {
    TimeNetUtil().getMovieDetail(movieId, (MovieDetailModel model) {
      setState(() {
        model.data.movie.actorsStuffs.insert(0, model.data.movie.director);
        _movie = model.data.movie;
        _boxOffice = model.data.boxOffice;
        print(
            "fetchMovieDetail.fetchMovieDetail.fetchMovieDetail------->${model.data.movie.titleCn}-----${model.data.movie.type}");
      });
    });
  }

  /// 获取影评信息
  void fetchMovieComments(String movieId) {
    TimeNetUtil().getMovieCommentsApi(movieId, (MovieCommentModel model) {
      setState(() {
        _comments = model.data.mini.list;
        _comments.addAll(model.data.plus.list);
      });
    });
  }

  /// 获取花絮
  void fetchMovieTricks(String movieId) {
    TimeNetUtil().getMovieTricksApi(movieId, (TricksModel model) {
      setState(() {
        print("fetchMovieTricks--->${model.videos}");
        _videos = model.videos;
      });
    });
  }

  
}
