import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/api/user_api.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/model/Event.dart';
import 'package:flutter_workbook/model/UserOrg.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/page/user/user_header.dart';
import 'package:flutter_workbook/page/user/user_item.dart';
import 'package:flutter_workbook/widget/event_item_widget.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';
import 'package:flutter_workbook/widget/scroll/sliver_header_delegate.dart';
import 'package:provider/provider.dart';

abstract class BasePersonState<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin<T>, SingleTickerProviderStateMixin {
  /// 列表请求页码
  int page = 1;

  /// 控制刷新、加载列表
  final LoadmoreController controller = LoadmoreController();

  /// 控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  /// 获取列表数据
  List<dynamic> get dataList => controller.dataList;

  /// 获取列表数据长度
  int get dataLength => dataList.length;

  /// 重置页码
  pageReset() => page = 1;

  /// 增加页码
  pageIncrease() => page++;

  /// 判断是否需要加载更多
  checkNeedLoadMore(ResultData? res) {
    return res != null && res.data != null && res.data.length % Config.PAGE_SIZE == 0;
  }

  /// 用于控制列表刷新
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  /// 用户组织列表
  final List<UserOrg> organizationList = [];

  final HonorModel honorModel = HonorModel();

  /// 页面是否开启缓存
  @override
  bool get wantKeepAlive => true;

  /// 自动下拉刷新页面
  showRefreshLoading() {
    Future.delayed(const Duration(milliseconds: 200), () {
      refreshIndicatorKey.currentState!.show();
      return true;
    });
  }

  /// 获取用户组织信息
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

  getUserStarred(String? username) {}

  Widget renderItem({
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
