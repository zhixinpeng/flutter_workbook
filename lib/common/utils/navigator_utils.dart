import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workbook/page/home/home_page.dart';
import 'package:flutter_workbook/page/login/login_page.dart';
import 'package:flutter_workbook/page/login/login_webview.dart';
import 'package:flutter_workbook/widget/never_overscroll_widget.dart';

class NavigatorUtils {
  /// Page 页面通用容器
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(
      // 不受系统字体缩放影响
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: NeverOverScrollWidget(
        needOverload: false,
        child: widget,
      ),
    );
  }

  /// 公共打开方式
  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, CupertinoPageRoute(builder: (context) => pageContainer(widget, context)));
  }

  /// 跳转到主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  /// 跳转到登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  /// 跳转到登录 Web 页面
  static goLoginWebView(BuildContext context, String url, String title) {
    return navigatorRouter(context, LoginWebView(url, title));
  }

  /// 弹出 Dialog
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible: true,
    WidgetBuilder? builder,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window).copyWith(textScaleFactor: 1),
          child: NeverOverScrollWidget(
            needOverload: false,
            child: SafeArea(
              child: builder!(context),
            ),
          ),
        );
      },
    );
  }
}
