import 'dart:collection';
import 'package:connectivity/connectivity.dart';
import 'package:book/framework/base_result.dart';
import 'package:book/framework/http_code.dart';
import 'package:book/framework/config.dart';
import 'package:book/framework/error_result.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class BookHttpUtils {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  static final String HTTP_METHOD_GET = "GET";
  static final String HTTP_METHOD_POST = "POST";

  static String _baseUrl = HttpConfig.BASE_URL;

  static post(url, params, cancelToken) async {
    var options = BaseOptions(method: HTTP_METHOD_POST);
    return await _request(url, params, null, options, cancelToken);
  }

  static get(url, {params, cancelToken}) async {
    var options = BaseOptions(method: HTTP_METHOD_GET);
    return await _request(url, params, null, options, cancelToken);
  }

  static setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  /// 最终实际调用网络请求的方法
  static _request(url, params, Map<String, dynamic> headers,
      BaseOptions options, CancelToken cancelToken) async {
    /// 网络状态处理
    var networkResult = await (new Connectivity().checkConnectivity());
    if (networkResult == ConnectivityResult.none) {
      showToast("Network Error...");
      return BaseResult(ErrorResult("Network Error...", HttpCode.NETWORK_ERROR),
          HttpCode.NETWORK_ERROR, false);
    } else if (networkResult == ConnectivityResult.mobile) {
      // todo  移动网络情景处理
    }

    /// 对 options 判空处理
    if (options == null) {
      options = new BaseOptions(method: 'GET');
    }

    /// http header 处理
    var headers = _addHeader();
    if (headers != null) {
      options.headers = headers;
    }

    /// 设置超时时间
    options.connectTimeout = 15000;
    options.receiveTimeout = 15000;

    /// 设置 base url,
    /// 如果设置了，那么参数里边的 [url] 就直接传递 path 即可
    /// 如果不设置，那么参数 [url] 就需要传递 host + path 的格式
    options.baseUrl = _baseUrl;

    /// 实例化网络请求对象
    var dio = Dio(options);

    /// options 参数可以在构造 Dio 的时候传入，也可以在调用 request 方法的时候传入
    Response response;

    /// 添加拦截器
    if (HttpConfig.DEBUG) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("stackTrace = ${e.stackTrace}");
        print("\n");
      }));
    }
    try {
      response = await dio.request(url, data: params, cancelToken: cancelToken);
    } on DioError catch (error) {
      /// 处理错误信息
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 10000);
      }
      if (error.type == DioErrorType.CONNECT_TIMEOUT ||
          error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = HttpCode.NETWORK_TIMEOUT;
      } else if (error.type == DioErrorType.CANCEL) {}
      if (HttpConfig.DEBUG) {
        print('请求异常: ' + error.toString());
        print('请求异常: url: ' + "${options.baseUrl}$url");
        if (params != null) {
          print("请求异常: 请求参数：" + params.toString());
        }
        if (response != null) {
          print("请求异常: 返回参数：" + response.toString());
        }
      }
      showToast(error.message);

      return new BaseResult(
          ErrorResult(error.message, errorResponse.statusCode),
          errorResponse.statusCode,
          false);
    }

    /// 处理成功返回的 response
    try {
      if (response.statusCode == HttpCode.SUCCESS) {
        if (HttpConfig.DEBUG) {
          print("请求成功: 返回数据：" + response.data.toString());
        }

        /// 针对不同的 返回类型处理
        if (options.contentType != null &&
            options.contentType.primaryType == ContentType.text.primaryType) {
          return BaseResult(response.data, HttpCode.SUCCESS, true);
        } else {
          /// 其他默认都是 json 格式数据类型
          var responseJson = response.data;
          return BaseResult(responseJson, HttpCode.SUCCESS, true);
        }
      }
    } catch (error) {
      showToast(error.toString());
      print("请求异常[返回]: 异常 URL ===>" + "${options.baseUrl}$url");
      return BaseResult(ErrorResult(error.toString(), response.statusCode),
          response.statusCode, false);
    }

    return BaseResult(ErrorResult(response.data, response.statusCode),
        response.statusCode, false);
  }

  /// 添加 header 信息
  /// 按需 : 从原生那边调用 token，user-agent 等信息
  static Map<String, String> _addHeader() {
    Map<String, String> headers = new HashMap();
    headers['token'] = "token-yanftch";
    headers['user'] = "user-yanftch";
    return headers;
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 3,
    );
  }

  /// 移除拦截器
//  void _removeInterceptors() {
//    dio.interceptors.requestLock.clear();
//    dio.interceptors.responseLock.clear();
//    dio.interceptors.errorLock.clear();
//  }
}
