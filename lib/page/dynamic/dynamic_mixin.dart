import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/api/event_api.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

mixin DynamicMixin<T extends StatefulWidget> on State<T> {
  /// 列表请求页码
  int _page = 1;

  /// 控制刷新、加载列表
  final LoadmoreController controller = LoadmoreController();

  /// 控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  /// 获取列表数据
  List<dynamic> get dataList => controller.dataList;

  /// 获取列表数据长度
  int get dataLength => dataList.length;

  /// 判断是否需要加载更多
  checkNeedLoadMore(ResultData? res) {
    return res != null && res.data != null && res.data.length == Config.PAGE_SIZE;
  }

  /// 重置页码
  pageReset() => _page = 1;

  /// 增加页码
  pageIncrease() => _page++;

  /// 发起刷新请求
  requestRefresh({String? username}) async {
    pageReset();

    var res = await EventApi.getEventReceived(username: username, page: _page);
    controller.needLoadMore = checkNeedLoadMore(res);
    controller.dataList = res.data;
    return res;
  }

  /// 发起加载更多请求
  requestLoadMore({String? username}) async {
    pageIncrease();
    var res = await EventApi.getEventReceived(username: username, page: _page);
    controller.needLoadMore = checkNeedLoadMore(res);
    controller.addList(res.data);
  }

  /// 自动下拉刷新页面
  showRefreshLoading() {
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        -141,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
      return true;
    });
  }
}
