import 'package:book/utils/sqlite_helper.dart';
import 'package:book/domins.dart' show DbModel;
import 'package:flutter/material.dart';

class CollectionUtils {
  static DbHelper dbHelper = DbHelper();

  static void collect(
      {@required String url,
      @required String title,
      @required String type,
      @required int movieId}) {
    var item = DbModel(url: url, title: title, type: type, movieId: movieId);
    dbHelper.insert(item);
  }

  static void unCollect(
      {@required String url,
      @required String title,
      @required String type,
      @required int movieId}) {
    var item = DbModel(url: url, title: title, type: type, movieId: movieId);
    dbHelper.deleteByUrl(url);
  }

  /// 遍历本地的所有已收藏数据，判断当前是否已经收藏
  static Future<bool> hasCollected(String url) async {
    /// 取出来所有收藏
    var items = await dbHelper.getModels();
    bool liked = false;
    items.forEach((item) {
      print("保存的 URL：${item.url}            url=$url");
      if (item.url == url) {
        liked = true;
        return;
      }
    });
    return Future.value(liked);
  }
}
