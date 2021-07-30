import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/common/utils/common_utils.dart';
import 'package:flutter_workbook/common/utils/navigator_utils.dart';
import 'package:flutter_workbook/redux/redux_epics/epic_store.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/// login combine reducer
final loginReducer = combineReducers<bool?>([
  TypedReducer<bool?, LoginSuccessAction>(_login),
  TypedReducer<bool?, LogoutAction>(_logout),
]);

/// login update reducer
bool? _login(bool? login, LoginSuccessAction action) {
  if (action.success) {
    NavigatorUtils.goHome(action.context);
  }
  return action.success;
}

/// login update reducer
bool? _logout(bool? logout, LogoutAction action) {
  return true;
}

/// login update action
class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

/// login update action
class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

/// login middleware action
class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

/// login middleware
Stream<dynamic> oauthEpic(Stream<dynamic> actions, EpicStore<ReduxState> store) {
  Stream<dynamic> _login(OAuthAction action, EpicStore<ReduxState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserApi.oauth(action.code, store);
    Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }

  return actions.whereType<OAuthAction>().switchMap((action) => _login(action, store));
}
