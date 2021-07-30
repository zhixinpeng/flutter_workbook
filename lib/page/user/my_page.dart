import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/common/api/event_api.dart';
import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/page/user/base_person_state.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/redux/redux_user.dart';
import 'package:flutter_workbook/widget/scroll/nested_loadmore_widget.dart';
import 'package:redux/redux.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends BasePersonState<MyPage> {
  Color notifyColor = ThemeColors.subTextColor;
  String starredCount = '---';

  /// 更新通知图标颜色
  _refreshNotify() {}

  /// 获取全局状态
  Store<ReduxState>? _getStore() => StoreProvider.of(context);

  /// 从全局状态中获取我的用户名
  _getUserName() {
    if (_getStore()?.state.userInfo == null) return;
    return _getStore()?.state.userInfo?.login;
  }

  /// 从全局状态中获取我的用户类型
  _getUserType() {
    if (_getStore()?.state.userInfo == null) return;
    return _getStore()?.state.userInfo?.type;
  }

  /// 获取数据
  _getDataLogic() async {
    if (_getUserName() == null) return [];
    if (_getUserType() == 'Organization') {
      return await UserApi.getMember(_getUserName(), page);
    } else {
      return await EventApi.getEvent(_getUserName(), page: page);
    }
  }

  @override
  bool get isRefreshFirst => false;

  @override
  bool get needRefresh => false;

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    if (_getUserName() != null) {
      // 通过 redux middleware 提交更新用户数据行为，触发网络更新请求
      _getStore()?.dispatch(FetchUserAction());

      // 获取用户组织信息
      getUserOrganization(_getUserName());

      // 获取用户仓库前 100 个 star 统计数据
      getUserStarred(_getUserName());

      _refreshNotify();
    }

    return await _getDataLogic();
  }

  @override
  requestLoadMore() async {
    return await _getDataLogic();
  }

  @override
  void initState() {
    controller.needRefresh = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (controller.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // AutomaticKeepAliveClientMixin
    super.build(context);

    return StoreBuilder<ReduxState>(
      builder: (context, store) {
        return NestedLoadmoreWidget(
          controller: controller,
          onRefresh: onRefresh,
          onLoadMore: onLoadMore,
          refreshKey: nestedRefreshIndicatorKey,
          itemBuilder: (BuildContext context, int index) => renderItem(
            index: index,
            userInfo: store.state.userInfo!,
            notifyColor: notifyColor,
            refreshCallback: _refreshNotify,
            organizationList: organizationList,
            starred: starredCount,
          ),
          headerSliversBuilder: (context, innerBoxIsScrolled) {
            return sliverBuilder(
              context: context,
              innerBoxIsScrolled: innerBoxIsScrolled,
              userInfo: store.state.userInfo!,
              notifyColor: notifyColor,
              starredCount: starredCount,
              refreshCallback: _refreshNotify,
            );
          },
        );
      },
    );
  }
}
