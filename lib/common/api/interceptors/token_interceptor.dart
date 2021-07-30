import 'package:dio/dio.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/common/storage/local_storage.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers['Authorization'] = _token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token ' + responseJson['token'];
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    super.onResponse(response, handler);
  }

  /// 获取授权 token
  Future<String?> getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String? basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        // 提示输入账号密码
      } else {
        // 通过 basic 去获取 token
        return "Basic $basic";
      }
    } else {
      _token = token;
      return token;
    }
  }

  /// 清除授权 token
  clearAuthorization() {
    _token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }
}
