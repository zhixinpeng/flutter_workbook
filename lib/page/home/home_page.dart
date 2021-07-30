import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/page/dynamic/dynamic_page.dart';
import 'package:flutter_workbook/page/user/my_page.dart';
import 'package:flutter_workbook/page/trend/trend_page.dart';
import 'package:flutter_workbook/widget/tabbar_widget.dart';
import 'package:flutter_workbook/widget/title_widget.dart';

class HomePage extends StatefulWidget {
  static final String sName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<DynamicPageState> dynamicKey = GlobalKey();
  final GlobalKey<TrendPageState> trendKey = GlobalKey();
  final GlobalKey<MyPageState> myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> tabs = [
      BottomNavigationBarItem(icon: Icon(ThemeIcons.MAIN_DT), label: S.current.home_dynamic),
      BottomNavigationBarItem(icon: Icon(ThemeIcons.MAIN_QS), label: S.current.home_trend),
      BottomNavigationBarItem(icon: Icon(ThemeIcons.MAIN_MY), label: S.current.home_my)
    ];

    return WillPopScope(
        onWillPop: () async {
          // 如果是 Android 返回桌面
          if (Platform.isAndroid) {
            AndroidIntent intent = AndroidIntent(
              action: 'android.intent.action.MAIN',
              category: 'android.intent.category.HOME',
            );
            await intent.launch();
          }
          return Future.value(false);
        },
        child: TabbarWidget(
          type: TabType.bottom,
          indicatorColor: ThemeColors.white,
          title: TitleWidget(
            S.current.app_name,
            iconData: ThemeIcons.MAIN_SEARCH,
            needRightLocalIcon: true,
          ),
          bottomNavigationBarItems: tabs,
          tabViews: [
            DynamicPage(key: dynamicKey),
            TrendPage(key: trendKey),
            MyPage(key: myKey),
          ],
        ));
  }
}
