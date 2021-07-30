import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_workbook/common/api/index.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/common/config/ignoreConfig.dart';
import 'package:flutter_workbook/common/net/address.dart';
import 'package:flutter_workbook/common/storage/local_storage.dart';
import 'package:flutter_workbook/common/utils/common_utils.dart';
import 'package:flutter_workbook/model/UserOrg.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/redux/redux_locale.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/redux/redux_user.dart';
import 'package:redux/redux.dart';

class UserApi {
  /// 初始化用户信息
  static Future<ResultData<User?>> initUserInfo(Store<ReduxState> store) async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();

    if (res.data != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
    }

    /// 读取主题
    String? themeIndex = await LocalStorage.get(Config.THEME_COLOR);
    if (themeIndex != null && themeIndex.length != 0) {
      CommonUtils.pushTheme(store, int.parse(themeIndex));
    }

    /// 切换语言
    String? localeIndex = await LocalStorage.get(Config.LOCALE);
    if (localeIndex != null && localeIndex.length != 0) {
      CommonUtils.changeLocale(store, int.parse(localeIndex));
    } else {
      CommonUtils.currentLocale = store.state.platformLocale;
      store.dispatch(UpdateLocaleAction(store.state.platformLocale));
    }

    return ResultData(res.data, (res.result && (token != null)));
  }

  /// 获取用户信息的本地存储
  static Future<ResultData<User?>> getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return ResultData<User>(user, true);
    } else {
      return ResultData(null, false);
    }
  }

  /// 获取用户详细信息
  static getUserInfo({String? username}) async {
    ResultData? res;

    if (username == null) {
      res = await httpManager.fetch(Address.getMyUserInfo(), null, null, null);
    } else {
      res = await httpManager.fetch(Address.getUserInfo(username), null, null, null);
    }

    if (res != null && res.result) {
      String? starred = '---';
      if (res.data['type'] != 'Organization') {
        var starredResult = await getUserStarredCount(res.data['login']);
        if (starredResult.result) {
          starred = starredResult.data;
        }
      }

      User user = User.fromJson(res.data);
      user.starred = starred;

      if (username == null) {
        LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
      }

      return ResultData(user, true);
    } else {
      return ResultData(res?.data, false);
    }
  }

  /// Github 授权登录
  static oauth(code, store) async {
    httpManager.clearAuthorization();

    var res = await httpManager.fetch(
      'https://github.com/login/oauth/access_token?client_id=${GithubConfig.CLIENT_ID}&client_secret=${GithubConfig.CLIENT_SECRET}&code=$code',
      null,
      null,
      Options(method: 'POST'),
    );

    dynamic resultData;

    if (res != null && res.result) {
      print("---- oauth - ${res.data} ----");
      var result = Uri.parse('pengzhixin://oauth?' + res.data);
      var token = result.queryParameters['access_token']!;
      var _token = 'token ' + token;

      await LocalStorage.save(Config.TOKEN_KEY, _token);

      resultData = await getUserInfo();

      if (Config.DEBUG) {
        print('---- oauth - ${res.data.toString()} ----');
      }

      if (resultData.result == true) {
        store.dispatch(UpdateUserAction(resultData.data));
      }

      return ResultData(resultData, res.result);
    }
  }

  /// 获取用户 Star 数目
  static getUserStarredCount(username) async {
    String url = Address.getUserStar(username, null) + '&per_page=1';
    var res = await httpManager.fetch(url, null, null, null);

    if (res != null && res.result && res.headers != null) {
      try {
        List<String>? link = res.headers['link'];
        if (link != null) {
          int indexStart = link[0].lastIndexOf('page=') + 5;
          int indexEnd = link[0].lastIndexOf('>');
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = link[0].substring(indexStart, indexEnd);
            return ResultData(count, true);
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return ResultData(null, false);
  }

  /// 获取用户组织
  static Future<ResultData<List<UserOrg>?>> getUserOrganization(String username, int page) async {
    String url = Address.getUserOrganization(username) + Address.getPageParams('?', page);
    var res = await httpManager.fetch(url, null, null, null);
    if (res != null && res.result) {
      List<UserOrg> list = [];
      List<dynamic>? data = res.data;
      if (data == null || data.length == 0) {
        return ResultData(null, true);
      }
      for (int i = 0; i < data.length; i++) {
        list.add(UserOrg.fromJson(data[i]));
      }
      return ResultData(list, true);
    } else {
      return ResultData(null, false);
    }
  }

  /// 获取组织成员
  static Future<ResultData<List<User>?>> getMember(String username, int page) async {
    String url = Address.getMember(username) + Address.getPageParams('?', page);
    var res = await httpManager.fetch(url, null, null, null);
    if (res != null && res.result) {
      List<User> list = [];
      List<dynamic>? data = res.data;
      if (data == null || data.length == 0) {
        return ResultData(null, true);
      }
      for (int i = 0; i < data.length; i++) {
        list.add(User.fromJson(data[i]));
      }
      return ResultData(list, true);
    } else {
      return ResultData(null, false);
    }
  }
}
