import 'package:book/domins.dart';
import 'package:book/utils/sp_util.dart';

/// 缓存一些数据到本地，减少 API 的调用(针对那些有调用次数限制的 API)
class Cache {
  static final String SP_KEY_HISTORYS = 'sp_key_historys';

  /// 缓存首页[历史上的今天]的数据
  static cacheHomeHistorys(List<History> list) {
    SpUtil.putObjectList(SP_KEY_HISTORYS, list);
  }

  static getHomeHistorys() async {
    var value = SpUtil.getObjList(SP_KEY_HISTORYS, (history) {});
    return value;
  }
}
