import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/model/Event.dart';
import 'package:flutter_workbook/model/UserOrg.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/page/user/user_header.dart';
import 'package:flutter_workbook/page/user/user_item.dart';
import 'package:flutter_workbook/widget/event_item_widget.dart';
import 'package:flutter_workbook/widget/scroll/list_state_mixin.dart';
import 'package:flutter_workbook/widget/scroll/nested_refresh.dart';
import 'package:flutter_workbook/widget/scroll/sliver_header_delegate.dart';
import 'package:provider/provider.dart';

abstract class BasePersonState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T>, ListStateMixin<T>, SingleTickerProviderStateMixin {
  final GlobalKey<NestedScrollViewRefreshIndicatorState> nestedRefreshIndicatorKey =
      GlobalKey<NestedScrollViewRefreshIndicatorState>();

  final List<UserOrg> organizationList = [];

  final HonorModel honorModel = HonorModel();

  @protected
  getUserOrganization(String? username) async {
    if (page > 1 || username == null) return;
    var res = await UserApi.getUserOrganization(username, page);
    if (res.data != null && res.result) {
      setState(() {
        organizationList.clear();
        organizationList.addAll(res.data!);
      });
    }
  }

  @protected
  getUserStarred(String? username) {}

  @override
  bool get wantKeepAlive => true;

  @override
  showRefreshLoading() {
    Future.delayed(const Duration(seconds: 0), () {
      nestedRefreshIndicatorKey.currentState?.show().then((e) {});
    });
    return super.showRefreshLoading();
  }

  @protected
  renderItem({
    required int index,
    required User userInfo,
    required String starred,
    required List<UserOrg> organizationList,
    Color? notifyColor,
    VoidCallback? refreshCallback,
  }) {
    if (userInfo.type == 'Organization') {
      return UserItem();
    } else {
      Event event = controller.dataList[index];
      return EventItemWidget(
        EventViewModel.fromEventMap(event),
        onPressed: () {},
      );
    }
  }

  @protected
  List<Widget> sliverBuilder({
    BuildContext? context,
    required User userInfo,
    required Color notifyColor,
    required String starredCount,
    bool? innerBoxIsScrolled,
    VoidCallback? refreshCallback,
  }) {
    double headerSize = 210;
    double bottomSize = 70;
    double chartSize = (userInfo.login != null && userInfo.type == 'Organization') ? 70 : 215;

    return <Widget>[
      // 个人信息简介
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderDelegate(
          maxHeight: headerSize,
          minHeight: headerSize,
          changeSize: true,
          vSync: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 10),
          ),
          builder: (context, shrinkOffset, overlapsContent) {
            return Transform.translate(
              offset: Offset(0, -shrinkOffset),
              child: SizedBox.expand(
                child: Container(
                  child: UserHeader(
                    userInfo: userInfo,
                    starredCount: starredCount,
                    themeColor: Theme.of(context).primaryColor,
                    notifyColor: notifyColor,
                    refreshCallback: refreshCallback,
                    orgList: organizationList,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // 悬浮展示信息
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: SliverHeaderDelegate(
          maxHeight: bottomSize,
          minHeight: bottomSize,
          changeSize: true,
          vSync: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          builder: (context, shrinkOffset, overlapsContent) {
            Radius radius = Radius.circular(10 - shrinkOffset / bottomSize * 10);
            return SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 0, right: 0),
                // 使用 MutiProvider 共享 HonorModel 状态
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => honorModel),
                  ],
                  child: Consumer<HonorModel>(
                    builder: (context, value, child) {
                      return UserHeaderBottom(
                        userInfo: userInfo,
                        beStarredCount: honorModel.beStarredCount?.toString() ?? '---',
                        radius: radius,
                        honorList: honorModel.honorList,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // 提交图表
      SliverPersistentHeader(
        delegate: SliverHeaderDelegate(
          maxHeight: chartSize,
          minHeight: chartSize,
          changeSize: true,
          vSync: this,
          snapConfig: FloatingHeaderSnapConfiguration(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 10),
          ),
          builder: (context, shrinkOffset, overlapsContent) {
            return SizedBox.expand(
              child: Container(
                height: chartSize,
                child: UserHeaderChart(userInfo),
              ),
            );
          },
        ),
      ),
    ];
  }
}

/// Provider HonorModel
class HonorModel extends ChangeNotifier {
  int? _beStarredCount;

  int? get beStarredCount => _beStarredCount;

  set beStarredCount(int? value) {
    _beStarredCount = value;
    notifyListeners();
  }

  List? _honorList;

  List? get honorList => _honorList;

  set honorList(List? value) {
    _honorList = value;
    notifyListeners();
  }
}
