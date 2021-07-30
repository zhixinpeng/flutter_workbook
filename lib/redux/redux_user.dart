import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/redux/redux_epics/epic_store.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/// user combine reducer
final userReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateUser),
]);

/// user update reducer
User? _updateUser(User? user, UpdateUserAction action) {
  user = action.userInfo;
  return user;
}

/// user update action
class UpdateUserAction {
  final User? userInfo;

  UpdateUserAction(this.userInfo);
}

/// user middleware action
class FetchUserAction {}

/// user middleware
Stream<dynamic> userInfoEpic(Stream<dynamic> actions, EpicStore<ReduxState> store) {
  Stream<dynamic> _loadUserInfo() async* {
    print("****** userInfoEpic _loadUserInfo ******");
    var res = await UserApi.getUserInfo();
    yield UpdateUserAction(res.data);
  }

  return actions
      .whereType<FetchUserAction>()
      .debounce((_) => TimerStream(true, const Duration(milliseconds: 10)))
      .switchMap((action) => _loadUserInfo());
}
