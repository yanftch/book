/*{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}*/

class WanAndroidBaseResp {
  int errorCode; //大于等于0的表示请求成功的
  String errorMsg;
  var data;

  WanAndroidBaseResp(this.errorCode, this.errorMsg, this.data);

  static WanAndroidBaseResp init(Map json) {
    if(json != null){
    return WanAndroidBaseResp(json['errorCode'], json['errorMsg'], json['data']);
    }else{
    return WanAndroidBaseResp(10000, "", "");
    }
  }

  @override
  String toString() {
    return 'WanAndroidBaseResp{errorCode: $errorCode, errorMsg: $errorMsg, data: $data}';
  }
}