import 'package:book/http/apis.dart';
import 'package:flutter/material.dart';
import 'package:book/net/BaseResp.dart';
import 'package:book/net/HttpUtils.dart';
import 'package:book/widgets.dart' show FetchResult;
import 'package:book/domins.dart';

///
///https://juejin.im/post/5b5d782ae51d45191c7e7fb3#heading-7   json 解析
///
class NetManager {
  static var page = 0;

  /// 获取首页列表数据
  /// @param page 分页页码
  /// [increment]指定是否为增量加载(翻页)
  // static Future<FetchResult<HomeItemBean>> fetchHomeListApi([
  //   bool isIncremental = false,
  // ]) async {
  //   page = isIncremental ? (page + 1) : 0;
  //   print("isIncremental-------->$isIncremental");
  //   BaseResp baseResp = await HttpUtils.getRequest(
  //       "article/list/" + page.toString() + "/json", null, null,
  //       showLoading: true);
  //   BaseResp ta = BaseResp.init(baseResp.data);
  //   HomeBean homeBean = HomeBean.fromJson(ta.data);
  //   return FetchResult<HomeItemBean>(homeBean.datas, true);
  // }

  // /// 获取首页 banner 数据
  // static Future<List<HomeBannerBean>> fetchHomeBanner() async{
  //   BaseResp baseResp =  await HttpUtils.getRequest(Api.HOME_BANNER, null, null);

  //   BaseResp base = BaseResp.init(baseResp.data);
  //   List<HomeBannerBean> banners =  HomeBannerBean.fromJsons(base.data);
  //   return banners;
  // }



  //登录接口
  static loginApi() async {
    BaseResp baseResp = await HttpUtils.postRequest(
        "/user/login?username=18310257489&password=qqqq1111", null, null);
    print("TAG--222--" + "" + baseResp.toString());
  }



  //获取体系结构列表
  static treeApi(BuildContext context) async {
    BaseResp baseResp = await HttpUtils.getRequest(
        "/tree/json", null, null,
        showLoading: true);
    BaseResp bean = BaseResp.init(baseResp.data);
    SystemTreeBean systemTreeBean = SystemTreeBean.fromJson(bean.data);
    return systemTreeBean.data;
  }

  //知识体系下的文章
  static treeArticleApi(BuildContext context, int id, int pageNo) async {
    BaseResp baseResp = await HttpUtils.getRequest(
        "/article/list/$pageNo/json?cid=$id", null, null,
        showLoading: true);
    BaseResp ta = BaseResp.init(baseResp.data);
    SystemTreeArticleBean articleBean = SystemTreeArticleBean.fromJson(ta.data);
    return articleBean;
  }

  static naviListApi(BuildContext context) async {
    BaseResp baseResp = await HttpUtils.getRequest(
        "/navi/json", null, null,
        showLoading: true);
    BaseResp ta = BaseResp.init(baseResp.data);
    NavigationBean naviBean = NavigationBean.fromJson(ta.data);
    print("TAG---naviListApi" + "===" + naviBean.data.length.toString());
    return naviBean;
  }

//  static sss() async {
//    BaseResp baseResp =
//        await HttpUtils.getRequest("/project/tree/json", null, null);
//    BaseResp ta = BaseResp.init(baseResp.data);
//    var list = ta.data as List;
//    List<Item> itemList = list.map((i) => Item.fromItemJson(i)).toList();
//    print("TAG---" + "长度；" + itemList.length.toString());
//    return itemList;
//  }
}

class Project {
  List<Item> data = new List();
}

class Item {
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  @override
  String toString() {
    return 'Item{courseId: $courseId, id: $id, name: $name, order: $order, parentChapterId: $parentChapterId, userControlSetTop: $userControlSetTop, visible: $visible}';
  }

  Item(
      {this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  factory Item.fromItemJson(Map<String, dynamic> parsedJson) {
    return Item(
        courseId: parsedJson['order'],
        id: parsedJson['id'],
        name: parsedJson['name'],
        order: parsedJson['order'],
        parentChapterId: parsedJson['parentChapterId'],
        userControlSetTop: parsedJson['userControlSetTop'],
        visible: parsedJson['visible']);
  }
}
