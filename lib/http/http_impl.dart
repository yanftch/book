import 'dart:math';
import 'package:book/http.dart';
import 'package:book/domins.dart';
import 'package:book/framework/widgets/pull_refresh.dart';
import 'dart:async';
import 'package:book/utils/t.dart';
import 'package:dio/dio.dart';
import 'package:book/http/WanAndroidBaseResp.dart';
import 'package:book/widgets.dart' show FetchResult;

/// 不区分那个 host 了，全部都在这统一整理请求方法
///
///https://juejin.im/post/5b5d782ae51d45191c7e7fb3#heading-7   json 解析
class HttpImpl {
  /// ***************************GANK***************************
  /// ***************************GANK***************************
  /// ***************************GANK***************************
  static const String API_GANK_HOST = 'http://gank.io';
  static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
  static const String API_DATA = "$API_GANK_HOST/api/data/";
  static const String API_SEARCH = "$API_GANK_HOST/api/search/query";
  static const String API_TODAY = "$API_GANK_HOST/api/today";
  static const String API_HISTORY = "$API_GANK_HOST/api/day/history";
  static const String API_HISTORY_CONTENT =
      "$API_GANK_HOST/api/history/content";
  static const String API_SUBMIT = "$API_GANK_HOST/api/add2gank";
  static const String CHECK_UPDATE = "$API_GANK_HOST/api/checkversion";
  static var page = 0;

  /// 每页加载数量，默认 20
  static const String DEFAULT_NUM = '20';
  static const category = [
    "App",
    "iOS",
    "拓展资源",
    "瞎推荐",
    "Android",
    "前端",
    "福利",
    "休息视频"
  ];

  /// 获取某一个类别下的数据
  static Future<List<GankInfo>> fetchCategoryDatas(
      [String category = "all", bool isIncrement = false]) async {
    page = isIncrement ? (page + 1) : 0;
    print("fetchCategoryDatas--------> page======>$page     "
        "请求 URL===>$API_DATA$category/$DEFAULT_NUM/$page");
    BaseResult baseResult =
        await BookHttpUtils.get("$API_DATA$category/$DEFAULT_NUM/$page");
    var gankCategory = GankCategory.fromJson(baseResult.data);
    return gankCategory.results;
  }

  /// 获取某一个类别下的数据
  static Future<FetchResult<GankInfo>> getDatasByCategory(String category,
      [bool isIncrement = false]) async {
    page = isIncrement ? (page + 1) : 0;
    print("isIncrement-------->$isIncrement   page======>$page"
        "请求 URL===>${API_DATA}$category/$DEFAULT_NUM/$page");
    BaseResult baseResult =
        await BookHttpUtils.get("${API_DATA}$category/$DEFAULT_NUM/$page");
    var gankCategory = GankCategory.fromJson(baseResult.data);
    return FetchResult<GankInfo>(gankCategory.results, true);
  }

  /// 获取 IOS 类别的数据
  /// @param page 分页页码
  /// [increment]指定是否为增量加载(翻页)
  static Future<FetchResult<GankInfo>> fetchiOSListApi([
    bool isIncremental = false,
  ]) async {
    page = isIncremental ? (page + 1) : 0;
    print("isIncremental-------->$isIncremental   page======>$page");
    BaseResult baseResult =
        await BookHttpUtils.get("${API_DATA}iOS/$DEFAULT_NUM/$page");
    var gankCategory = GankCategory.fromJson(baseResult.data);
    return FetchResult<GankInfo>(gankCategory.results, true);
  }

  /// [page] 当前是第几页，用于分页加载数据的处理
  static getIOSDatas(int page) async {
    BaseResult baseResult =
        await BookHttpUtils.get("${API_DATA}iOS/$DEFAULT_NUM/$page");
    return GankCategory.fromJson(baseResult.data);
  }

  static getRandomData() async {
    /// 随机一个类型
    Random random = Random();
    var i = random.nextInt(category.length);
    if (i < 0 || i > category.length) {
      i = 0;
    }
    print("random--->${category[i]}");

    BaseResult baseResult = await BookHttpUtils.get(
        "http://gank.io/api/random/data/${category[i]}/40");
    return baseResult;
  }

  /// ***************************玩 Android***************************
  /// ***************************玩 Android***************************
  /// ***************************玩 Android***************************
  ///
  static const String API_WANANDROID_HOST = 'http://www.wanandroid.com';
  static const String API_WANANDROID_HOME_BANNER = '$API_WANANDROID_HOST/banner/json';

  /// 获取首页列表数据
  /// @param page 分页页码
  /// [increment]指定是否为增量加载(翻页)
  static Future<FetchResult<HomeItemBean>> fetchHomeListApi([
    bool isIncremental = false,
  ]) async {
    page = isIncremental ? (page + 1) : 0;
    print("isIncremental-------->$isIncremental");
    BaseResult baseResult = await BookHttpUtils.get("$API_WANANDROID_HOST/article/list/" + page.toString() + "/json");
    WanAndroidBaseResp ta = WanAndroidBaseResp.init(baseResult.data);
    HomeBean homeBean = HomeBean.fromJson(ta.data);
    return FetchResult<HomeItemBean>(homeBean.datas, true);
  }

  /// 获取首页 banner 数据
  static Future<List<HomeBannerBean>> fetchHomeBanner() async {
    BaseResult baseResult = await BookHttpUtils.get(API_WANANDROID_HOME_BANNER);
    WanAndroidBaseResp base = WanAndroidBaseResp.init(baseResult.data);
    List<HomeBannerBean> banners = HomeBannerBean.fromJsons(base.data);
    return banners;
  }

  /// 热搜关键词
  // static Future<>

  ///
  /// ***************************时光***************************
  /// ***************************时光***************************
  /// ***************************时光***************************
  final String TIME_BASE_URL = 'https://api-m.mtime.cn/';

  /// 正在售票
  static String hot_api =
      "https://api-m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=";

  /// 正在上映
  static String current_in_api =
      'https://api-m.mtime.cn/Showtime/LocationMovies.api?locationId=';

  /// 即将上映
  static String coming_movies =
      'https://api-m.mtime.cn/Movie/MovieComingNew.api?locationId=';

  /// 影片详情  替换参数：locationId & movieId
  static String movie_detail =
      'https://ticket-api-m.mtime.cn/movie/detail.api?locationId=290&movieId=';

  /// 影片评论 替换参数：locationId & movieId
  static String movie_comments =
      'https://ticket-api-m.mtime.cn/movie/hotComment.api?movieId=';

  /// 演职员表
  final String movie_actors =
      'https://api-m.mtime.cn/Movie/MovieCreditsWithTypes.api?movieId=217896';

  /// 预告片&花絮  pageIndex 就是分页值，movieId 可以分别从正在售票、正在热映、即将上映对应 json 的 movieId、id、id 字段中获取
  static String movie_tricks =
      'https://api-m.mtime.cn/Movie/Video.api?pageIndex=1&movieId=';

  static void getHotMovies(String id, Function callback) async {
    print("url: $hot_api$id");
    Dio().get("$hot_api$id").then((response) {
//      print("getHotMovies--->$response");
      if (response != null) {
        callback(HotModel.fromJson(response.data));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// 正在热映
  static void getNowShowingMovies(String id, Function callback) async {
    Dio().get("$current_in_api$id").then((response) {
//      print("getHotMovies--->$response");
      if (response != null) {
        callback(NowShowingMovieModel.fromJson(response.data));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// 即将上映
  static void getComingMovies(String id, Function callback) async {
    Dio().get("$coming_movies$id").then((response) {
      print("getComingMovies--->$response");
      if (response != null) {
        callback(ComingMovies.fromJson(response.data));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// 影片详情, 获取影片信息，以及演员导演信息等等
  static void getMovieDetail(String movieId, Function callback) async {
    Dio().get(movie_detail + movieId).then((response) {
      print("getMovieDetail--->$response");
      if (response != null) {
        callback(MovieDetailModel.fromJson(response.data));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// 获取影评信息
  static void getMovieCommentsApi(String movieId, Function callback) async {
    Dio().get(movie_comments + movieId).then((response) {
      print("getMovieCommentsApi--->$response");
      if (response != null) {
        callback(MovieCommentModel.fromJson(response.data));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// 获预告&花絮
  static void getMovieTricksApi(String movieId, Function callback) async {
    Dio().get(movie_tricks + movieId).then((response) {
      print("getMovieTricksApi--->${response.data}");
      if (response != null) {
        callback(TricksModel.fromJson(response.extra));
      }
    }).catchError((error) {
      var msg;
      if (error is DioError) {
        msg = error.message;
        print("getMovieDetail-->error: ${error.type}  ${error.message}");
      } else {
        msg = "API 异常";
        print("getMovieDetail-->error: other errors....");
      }
      T.show(msg);
    });
  }

  /// ***************************历史上的今天***************************
  /// ***************************历史上的今天***************************
  /// ***************************历史上的今天***************************
  static String apiKey = '341db9ae817fafbeedb1d501301c0aff';
  static String todayInHistory =
      "http://v.juhe.cn/todayOnhistory/queryEvent.php?key=$apiKey&date=";

  static String detailInHistory =
      "http://v.juhe.cn/todayOnhistory/queryDetail.php?key=$apiKey&e_id=";

  /// 根据输入的时间查询历史上的今天
  /// 格式 : [month/day]
  static Future<List<History>> getHistories(String date) async {
    //todo 判断输入格式是否是 month/day 的格式
    BaseResult baseResult = await BookHttpUtils.get("$todayInHistory$date");
    HistoryModel model = HistoryModel.fromJson(baseResult.data);
    return model.historys;
  }

  /// 历史上的今天详情
  static Future<HistoryModel> getHistory(String id) async {
    print("路径---$detailInHistory$id");

    BaseResult baseResult = await BookHttpUtils.get("$detailInHistory$id");
    print("baseResult======>${baseResult}");
    
    HistoryModel model = HistoryModel.fromJson(baseResult.data);
    return model;
  }
}
