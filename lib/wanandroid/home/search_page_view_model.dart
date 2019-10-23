import 'package:book/constants.dart';
import 'package:book/framework/mvvm/view_model.dart';
import 'package:book/http/http_impl.dart';
import 'package:book/utils/sp_util.dart';
import 'package:flutter/material.dart';

class SearchPageViewModel extends ViewModel {
  bool _isLoading = false;

  /// 获取热搜的关键词
  Future fetchHotKeys() async {
    print("更换热词。。。。");
    _isLoading = true;
    var hotBean = await HttpImpl.fetchHotKeys();
    _isLoading = false;
    if (hotBean != null) {
      return Future.value(hotBean.hotkeys);
    }
    return Future.value();
  }

  /// 保存历史记录
  save(String name) async {
    List<String> list = get();
    list.add(name);
    await SpUtil.putStringList(Constants.KEY_SEARCH_HISTORY, list);
  }

  /// 获取历史记录
  List<String> get() {
    var historys = SpUtil.getStringList(Constants.KEY_SEARCH_HISTORY);
    return (historys == null || historys.length == 0) ? [] : historys;
  }

  /// 清空历史记录
  clear() {
    SpUtil.remove(Constants.KEY_SEARCH_HISTORY);
  }
}
