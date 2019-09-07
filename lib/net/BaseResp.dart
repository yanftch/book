/*{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}*/

class BaseResp {
  int errorCode; //大于等于0的表示请求成功的
  String errorMsg;
  var data;

  BaseResp(this.errorCode, this.errorMsg, this.data);

  static BaseResp init(Map json) {
    if(json != null){
    return BaseResp(json['errorCode'], json['errorMsg'], json['data']);
    }else{
    return BaseResp(10000, "", "");
    }
  }

  @override
  String toString() {
    return 'BaseResp{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }
}