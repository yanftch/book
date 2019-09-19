import 'dart:math';
import 'package:book/http.dart';
import 'package:book/domins.dart';
import 'package:book/framework/widgets/pull_refresh.dart';

/// gank API 类
///
class HttpGankUtils {
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

  /// 获取今日数据
  static getTodayData() async {
    BaseResult baseResult =
        await BookHttpUtils.get("http://gank.io/api/xiandu/categories");
    return baseResult;
  }

  /// 获取某一个类别下的数据
  static getOneCategoryDatas() async {}


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

  static getAndroidDatas() async {}

  /// 获取随机数据
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
}


///
// ///
// import 'package:dio/dio.dart';
// import 'package:flutter_gank/common/network/http_manager.dart';
// import 'package:flutter_gank/common/network/http_response.dart';

// class GankApi {
//   /// gank api urls.
//   static const String API_GANK_HOST = 'http://gank.io';
//   static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
//   static const String API_DATA = "$API_GANK_HOST/api/data/";
//   static const String API_SEARCH = "$API_GANK_HOST/api/search/query";
//   static const String API_TODAY = "$API_GANK_HOST/api/today";
//   static const String API_HISTORY = "$API_GANK_HOST/api/day/history";
//   static const String API_HISTORY_CONTENT =
//       "$API_GANK_HOST/api/history/content";
//   static const String API_SUBMIT = "$API_GANK_HOST/api/add2gank";
//   static const String CHECK_UPDATE = "$API_GANK_HOST/api/checkversion";

//   ///获取最新一天的数据
//   static getTodayData() async {
//     HttpResponse response = await HttpManager.instance.request(API_TODAY);
//     return response.data;
//   }

//   ///获取指定日期的数据 [date:指定日期]
//   static getSpecialDayData(String date) async {
//     HttpResponse response = await HttpManager.instance
//         .request(API_SPECIAL_DAY + date.replaceAll("-", "/"));
//     return response.data;
//   }

//   ///获取分类数据 [category:分类, page: 页数, count:每页的个数]
//   static getCategoryData(String category, int page, {count = 20}) async {
//     String url = API_DATA + category + "/$count/$page";
//     HttpResponse response = await HttpManager.instance.request(url);
//     return response.data;
//   }

//   ///获取所有的历史干货日期.
//   static getHistoryDateData() async {
//     HttpResponse response = await HttpManager.instance.request(API_HISTORY);
//     return response.data['results'];
//   }

//   ///搜索[简易搜索，后面拆分页]
//   static searchData(String search) async {
//     HttpResponse response = await HttpManager.instance
//         .request(API_SEARCH + "/$search/category/all/count/50/page/1");
//     return response.data['results'];
//   }

//   ///提交干货[url:干货地址,desc:干货描述,type:干货类型,debug:true为测试提交，false为正式提交
//   static submitData(url, desc, who, type, {debug = false}) async {
//     FormData formData = FormData.from({
//       'url': url,
//       'desc': desc,
//       'who': who,
//       'type': type,
//       'debug': debug,
//     });
//     HttpResponse response = await HttpManager.instance
//         .request(API_SUBMIT, params: formData, method: HttpMethod.post);
//     return response.data;
//   }

//   ///获取所有的历史干货.
//   static getHistoryContentData(int page, {count = 20}) async {
//     HttpResponse response = await HttpManager.instance
//         .request(API_HISTORY_CONTENT + '/$count/$page');
//     return response.data['results'];
//   }
// }