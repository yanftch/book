import 'package:book/net/BaseResp.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:book/net/CommonCode.dart';
import 'package:book/net/ErrorEvent.dart';
import 'package:book/net/HttpConfig.dart';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:book/http.dart' show ApiConfig;

class HttpUtils {
  // TODO: 2018/11/7 动态配置请求头信息

  static Map<String, String> baseHeaders = {
    "x-noomi-channel": "enterprise",
    "x-noomi-device-id": "c8ac4a0",
    "x-noomi-version-code": "2002",
    "currency": "CNY",
    "accept-language": "zh",
    "language": "zh_CN",
    "x-noomi-agent":
        "os:android,os_version:8.1.0,device:MI+6X,app_version:2.0.2(2002),manufacturer:Xiaomi,os_full:android 8.1.0,Accept-Language:zh,carrier:%E4%B8%AD%E5%9B%BD%E7%A7%BB%E5%8A%A8,network:WIFI",
  };
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };
  static bool _loading = true;

  static postRequest(url, params, cancelToken,
      {showLoading = false}) async {
    BaseOptions option = new BaseOptions(method: "POST");
    return await _request(url, params, null, option, cancelToken,
        showLoading: showLoading);
  }

  static getRequest(url, params, cancelToken,
      {showLoading = false}) async {
    BaseOptions option = new BaseOptions(method: "GET");
    return await _request(url, params, null, option, cancelToken,
        showLoading: showLoading);
  }

  static _request(url, params, Map<String, String> header,
      BaseOptions option, CancelToken cancelToken,
      {showLoading = false}) async {
        print("url--->$url");
    var networkResult = await (new Connectivity().checkConnectivity());
    if (ConnectivityResult.mobile == networkResult) {
    } else if (ConnectivityResult.wifi == networkResult) {
    } else if (ConnectivityResult.none == networkResult) {
      return BaseResp(CommonCode.NETWORK_ERROR, "网络异常",
          ErrorEvent(CommonCode.NETWORK_ERROR, "网络异常"));
    }
    //请求头处理
    Map<String, String> headers = new HashMap();
    //添加默认的请求头信息
    headers.addAll(baseHeaders);
    if (header != null) {
      headers.addAll(header);
    }
    //options
    if (option != null) {
      option.headers = headers;
    } else {
      option = new BaseOptions(method: "GET");
      option.headers = headers;
    }
    option.baseUrl = ApiConfig.wanandroidBaseUrl;
    option.connectTimeout = 15000; //单位毫秒
    option.receiveTimeout = 15000;
    option.connectTimeout = 30000;

    var dio = new Dio(option);
    Response response;
    try {
      response = await dio.request(url, data: params, cancelToken: cancelToken);
    } on DioError catch (error) {
      // debugger();
      if (error.response != null) {
        print("TAG---" + "走异常了" + error.response.statusCode.toString());
      }
      //处理错误
      Response errorResp;
      if (error.response != null) {
        errorResp = error.response;
      } else {
        errorResp = new Response(statusCode: 10000);
      }
      //超时异常
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResp.statusCode = CommonCode.NETWORK_TIMEOUT;
        showToast("连接超时...");
        return new BaseResp(errorResp.statusCode, "连接超时...",
            ErrorEvent(CommonCode.NETWORK_TIMEOUT, "连接超时..."));
      }
      if (errorResp.statusCode == CommonCode.HTTP_CODE_404) {
        showToast("URL 出错了...");
      } else {}
      return new BaseResp(
          errorResp.statusCode, errorResp.data.toString(), errorResp.data);
    }
    if (HttpConfig.DEBUG) {
      print("HTTP-LOG-" + "请求 URL：${option.baseUrl}$url");
      print("HTTP-LOG-" + "请求头：" + option.headers.toString());
      if (params != null) {
        print("HTTP-LOG-" + "请求参数：" + params.toString());
      }
      if (response != null) {
        print("HTTP-LOG-" + "返回参数：" + response.toString());
      }
    }
    //处理 response

    try {
      if (response.statusCode == 200) {
        //解析
        if (HttpConfig.DEBUG) {
          print("TAG---" + "返回数据：" + response.data.toString());
        }
        if (response.data['errorCode'] >= 0) {
          return new BaseResp(response.data['errorCode'],
              response.data['errorMsg'], response.data);
        } else {
          showToast(response.data['errorMsg']);
          return null;
        }
      } else {}
    } catch (error) {
      print("TAG---url:" + url + error.toString());
      showToast(error.toString());
      return new BaseResp(10000, error.toString(), null);
    }
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIos: 3,
  );
}

void showHiddenDialog(BuildContext context, bool show) {
//  if (show) {
//    showDialog(
//        context: context,
//        barrierDismissible: false,
//        child: new SimpleDialog(
//          title: new Text('loading...'),
//          children: <Widget>[
//            new Center(
//              child: new CircularProgressIndicator(),
//            )
//          ],
//        ));
//  } else {
//    Navigator.pop(context);
//  }
}
