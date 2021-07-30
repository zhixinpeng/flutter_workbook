import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/page/home/home_page.dart';
import 'package:flutter_workbook/page/login/login_page.dart';
import 'package:flutter_workbook/page/welcome_page.dart';
import 'package:redux/redux.dart';

import 'common/style/theme.dart';
import 'common/utils/common_utils.dart';
import 'common/utils/navigator_utils.dart';
import 'redux/redux_state.dart';

class FlutterReduxApp extends StatefulWidget {
  const FlutterReduxApp({Key? key}) : super(key: key);

  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  // 创建全局 Store
  final store = Store(
    appReducer,
    middleware: middleware,
    initialState: ReduxState(
      userInfo: User.empty(),
      login: false,
      locale: Locale('zh', 'CH'),
      themeData: CommonUtils.getThemeData(ThemeColors.primarySwatch),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<ReduxState>(
        builder: (context, store) {
          store.state.platformLocale = WidgetsBinding.instance!.window.locale;
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: [
              store.state.locale ?? store.state.platformLocale!,
            ],
            locale: store.state.locale,
            theme: store.state.themeData,
            routes: {
              WelcomePage.sName: (context) {
                return WelcomePage();
              },
              HomePage.sName: (context) {
                return NavigatorUtils.pageContainer(HomePage(), context);
              },
              LoginPage.sName: (context) {
                return NavigatorUtils.pageContainer(LoginPage(), context);
              }
            },
          );
        },
      ),
    );
  }
}
