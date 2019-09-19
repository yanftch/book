/// 网络返回数据结果包装类

class BaseResult {
  var data;
  int code;
  bool hasResult;

  BaseResult(this.data, this.code, this.hasResult);

  @override
  String toString() {
    return 'BaseResult{data: $data, code: $code, hasResult: $hasResult}';
  }


//
//  BaseResult baseResult = await BookHttpUtils.get("article/list/0/json");
//  print("BaseResult--data->${baseResult.data}");
//  BaseResp baseResp = BaseResp.init(baseResult.data);
//  HomeBean homeBean = HomeBean.fromJson(baseResp.data);
//  print("${homeBean.datas[0].author}");

}
