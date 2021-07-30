import 'package:flutter/material.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/redux/redux_epics/epic_middleware.dart';
import 'package:flutter_workbook/redux/redux_locale.dart';
import 'package:flutter_workbook/redux/redux_login.dart';
import 'package:flutter_workbook/redux/redux_theme.dart';
import 'package:flutter_workbook/redux/redux_user.dart';
import 'package:redux/redux.dart';

/// 全局 Redux store state
class ReduxState {
  /// 用户信息
  User? userInfo;

  /// 主题数据
  ThemeData? themeData;

  /// 语言
  Locale? locale;

  /// 当前手机平台默认语言
  Locale? platformLocale;

  /// 是否登录
  bool? login;

  ReduxState({this.userInfo, this.themeData, this.locale, this.platformLocale, this.login});
}

/// 创建 Redux
ReduxState appReducer(ReduxState state, action) {
  return ReduxState(
    userInfo: userReducer(state.userInfo, action),
    themeData: themeDataReducer(state.themeData, action),
    locale: localeReducer(state.locale, action),
    login: loginReducer(state.login, action),
  );
}

/// Redux 中间件
final List<Middleware<ReduxState>> middleware = [
  EpicMiddleware<ReduxState>(oauthEpic),
  EpicMiddleware<ReduxState>(userInfoEpic),
];
