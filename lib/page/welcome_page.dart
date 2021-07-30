import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/common/utils/navigator_utils.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/widget/scale_text_widget.dart';
import 'package:flutter_workbook/widget/mole_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static final String sName = '/';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;
  String welcomeText = '';
  double fontSize = 76;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) return;
    hadInit = true;

    //  防止多次进入
    Store<ReduxState> store = StoreProvider.of(context);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        welcomeText = 'Welcome';
        fontSize = 60;
      });
    });

    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        welcomeText = 'GithubApp';
        fontSize = 60;
      });
    });

    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      UserApi.initUserInfo(store).then((res) {
        if (res.data != null && res.result) {
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<ReduxState>(
      builder: (context, store) {
        return Material(
          child: Container(
            color: ThemeColors.white,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image(image: AssetImage('static/images/welcome.png')),
                ),
                Align(
                  alignment: Alignment(0, .3),
                  child: ScaleTextWidget(
                    text: welcomeText,
                    textStyle: GoogleFonts.akronim().copyWith(
                      fontSize: fontSize,
                      color: ThemeColors.primaryDarkValue,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, .8),
                  child: MoleWidget(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: FlareActor(
                      'static/file/flare_flutter_logo_.flr',
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fill,
                      animation: 'Placeholder',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
