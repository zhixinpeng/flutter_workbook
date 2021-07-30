import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_workbook/common/api/code.dart';
import 'package:flutter_workbook/common/api/interceptors/token_interceptor.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/config/config.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  static Dio _dio = Dio();

  final TokenInterceptors _tokenInterceptors = TokenInterceptors();

  static init() {
    // if (Config.DEBUG) {
    //   // 调试模式下开启抓包代理
    //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 192.168.20.240:8888";
    //     };
    //     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  /// 初始化增加拦截器
  HttpManager() {
    _dio.interceptors.add(_tokenInterceptors);
  }

  /// 清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  /// 获取授权
  Future<String?> getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }

  /// 发起网络请求
  Future<ResultData>? fetch(
    String url,
    dynamic params,
    Map<String, dynamic>? header,
    Options? options, {
    noTip: false,
  }) async {
    Map<String, dynamic> headers = HashMap();

    if (header != null) {
      headers.addAll(header);
    }
    if (options != null) {
      options.headers = headers;
    } else {
      options = Options(method: 'get');
      options.headers = headers;
    }

    /// 请求错误处理
    ResultData<String> resultError(DioError e) {
      Response? errorResponse;

      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(requestOptions: RequestOptions(path: url), statusCode: 666);
      }

      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout) {
        errorResponse!.statusCode = ErrorCode.NETWORK_TIMEOUT;
      }

      return ResultData<String>(
        ErrorCode.errorHandleFunction(errorResponse!.statusCode, e.message, noTip),
        false,
        code: errorResponse.statusCode,
      );
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: options);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data);
    }

    return ResultData(response.data, true);
  }
}

final HttpManager httpManager = HttpManager();
