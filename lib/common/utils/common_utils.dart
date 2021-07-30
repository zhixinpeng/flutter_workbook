import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/common/net/address.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/common/utils/navigator_utils.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/redux/redux_locale.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/redux/redux_theme.dart';

import 'package:redux/redux.dart';

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale? currentLocale;

  /// 读取主题数据
  static getThemeData(Color color) {
    return ThemeData(
      primarySwatch: color as MaterialColor?,
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
    );
  }

  /// 更新主题
  static pushTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(UpdateThemeDataAction(themeData));
  }

  /// 获取主题颜色列表
  static List<Color> getThemeListColor() {
    return [
      ThemeColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  /// 切换语言
  static changeLocale(Store<ReduxState> store, int index) {
    Locale? locale = store.state.platformLocale;
    if (Config.DEBUG) {
      print(store.state.platformLocale);
    }
    switch (index) {
      case 1:
        locale = Locale('zh', 'CN');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    currentLocale = locale;
    store.dispatch(UpdateLocaleAction(locale));
  }

  /// 显示加载弹窗
  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showCustomDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: SpinKitCubeGrid(
                        color: ThemeColors.white,
                      ),
                    ),
                    Container(height: 10),
                    Container(
                      child: Text(
                        S.current.loading_text,
                        style: ThemeTextStyle.normalTextWhite,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 获取日期字符串
  static String getDateStr(DateTime? date) {
    if (date == null || date.toString() == "") {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  /// 日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTimes = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTimes < MILLIS_LIMIT) {
      return (currentLocale != null)
          ? (currentLocale!.languageCode != "zh")
              ? "right now"
              : "刚刚"
          : "刚刚";
    } else if (subTimes < SECONDS_LIMIT) {
      return (subTimes / MILLIS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale!.languageCode != "zh")
                  ? " seconds ago"
                  : " 秒前"
              : " 秒前");
    } else if (subTimes < MINUTES_LIMIT) {
      return (subTimes / SECONDS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale!.languageCode != "zh")
                  ? " min ago"
                  : " 分钟前"
              : " 分钟前");
    } else if (subTimes < HOURS_LIMIT) {
      return (subTimes / MINUTES_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale!.languageCode != "zh")
                  ? " hours ago"
                  : " 小时前"
              : " 小时前");
    } else if (subTimes < DAYS_LIMIT) {
      return (subTimes / HOURS_LIMIT).round().toString() +
          ((currentLocale != null)
              ? (currentLocale!.languageCode != "zh")
                  ? " days ago"
                  : " 天前"
              : " 天前");
    } else {
      return getDateStr(date);
    }
  }

  /// 获取用户提交图表地址
  static String getUserChartAddress(String username) {
    return Address.graphicHost + ThemeColors.primaryValueString.replaceAll('#', '') + '/' + username;
  }
}
