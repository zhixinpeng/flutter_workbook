import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/common/net/address.dart';
import 'package:flutter_workbook/common/storage/local_storage.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/common/utils/navigator_utils.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/redux/redux_login.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/widget/input_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  static final String sName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // 触摸收起键盘
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: <Widget>[
              Center(
                // 弹出键盘不遮挡
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: ThemeColors.cardWhite,
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(
                            image: AssetImage(ThemeIcons.DEFAULT_USER_ICON),
                            width: 90,
                            height: 90,
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          InputWidget(
                            hintText: S.current.login_username_hint_text,
                            iconData: ThemeIcons.LOGIN_USER,
                            onChanged: (String value) {
                              _username = value;
                            },
                            controller: userController,
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          InputWidget(
                            hintText: S.current.login_password_hint_text,
                            iconData: ThemeIcons.LOGIN_PW,
                            obscureText: true,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: passwordController,
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: login,
                                    child: Text(
                                      S.current.login_text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ThemeColors.textWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: oauthLogin,
                                    style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                                    child: Text(
                                      S.current.oauth_text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ThemeColors.textWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15)),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              S.current.switch_language,
                              style: TextStyle(color: ThemeColors.subLightTextColor),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String? _username = "";
  String? _password = "";

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _username = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = TextEditingValue(text: _username ?? "");
    passwordController.value = TextEditingValue(text: _password ?? "");
  }

  login() async {
    Fluttertoast.showToast(
      msg: S.current.login_deprecated,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  oauthLogin() async {
    String? code = await NavigatorUtils.goLoginWebView(context, Address.getOAuthUrl(), S.current.oauth_text);

    print('--- code webview catch is $code ----');

    if (code != null && code.length > 0) {
      /// 通过 redux 去执行登录流程
      StoreProvider.of<ReduxState>(context).dispatch(OAuthAction(context, code));
    }
  }
}
