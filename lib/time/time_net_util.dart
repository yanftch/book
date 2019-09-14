import 'dart:async';
import 'package:book/domins.dart';
import 'package:dio/dio.dart';

class TimeNetUtil {
  final String TIME_BASE_URL = 'https://api-m.mtime.cn/';

  /// 正在售票
  final String hot_api =
      "https://api-m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=290";

  /// 正在上映
  final String current_in_api =
      'https://api-m.mtime.cn/Showtime/LocationMovies.api?locationId=290';

  /// 即将上映
  final String coming_movies =
      'https://api-m.mtime.cn/Movie/MovieComingNew.api?locationId=290';

  void getHotMovies(Function callback) async {
    Dio().get(hot_api).then((response) {
//      print("getHotMovies--->$response");
      if (response != null) {
        callback(HotModel.fromJson(response.data));
      }
    });
  }
  /// 正在热映
  void getNowShowingMovies(Function callback) async {
    Dio().get(current_in_api).then((response) {
//      print("getHotMovies--->$response");
      if (response != null) {
        callback(NowShowingMovieModel.fromJson(response.data));
      }
    });
  }
  /// 即将上映
  void getComingMovies(Function callback) async {
    Dio().get(coming_movies).then((response) {
      print("getComingMovies--->$response");
      if (response != null) {
        callback(ComingMovies.fromJson(response.data));
      }
    });
  }




}
