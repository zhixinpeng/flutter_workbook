import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

mixin ListStateMixin<T extends StatefulWidget> on State<T>, AutomaticKeepAliveClientMixin<T> {
  final LoadmoreController controller = LoadmoreController();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final List dataList = [];

  /// 是否显示
  bool _isShow = false;

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否正在刷新
  bool _isRefreshing = false;

  /// 是否正在加载更多
  bool _isLoadingMore = false;

  /// 当前页码
  int page = 1;

  /// 是否需要头部
  @protected
  bool get needRefresh => false;

  /// 获取数据列表
  @protected
  List get getDataList => dataList;

  /// 是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst;

  /// 下拉刷新数据
  @protected
  requestRefresh() async {}

  /// 上拉加载更多数据
  @protected
  requestLoadMore() async {}

  @protected
  resolveRefreshResult(ResultData? res) {
    if (res != null && res.result) {
      controller.dataList.clear();
      if (_isShow) {
        setState(() {
          controller.dataList.addAll(res.data);
        });
      }
    }
  }

  @protected
  resolveDataResult(ResultData? res) {
    if (_isShow) {
      setState(() {
        controller.needLoadMore = (res != null && res.data != null && res.data.length >= Config.PAGE_SIZE);
      });
    }
  }

  @protected
  Future<Null> onRefresh() async {
    print('onRefresh');
    if (_isLoading) {
      if (_isRefreshing) return;
      await _lockAndWait();
    }

    _isLoading = true;
    _isRefreshing = true;
    page = 1;

    var res = await requestRefresh();
    resolveRefreshResult(res);
    resolveDataResult(res);

    _isLoading = false;
    _isRefreshing = false;
  }

  @protected
  Future<Null> onLoadMore() async {
    print('onLoadMore');
    if (_isLoading) {
      if (_isLoadingMore) return;
      await _lockAndWait();
    }

    _isLoading = true;
    _isLoadingMore = true;
    page++;

    var res = await requestLoadMore();
    if (res != null && res.result) {
      if (_isShow) {
        setState(() {
          controller.dataList.addAll(res.data);
        });
      }
    }
    resolveDataResult(res);

    _isLoading = false;
    _isLoadingMore = false;
  }

  @override
  void initState() {
    _isShow = true;
    controller.needRefresh = needRefresh;
    controller.dataList = getDataList;
    if (controller.dataList.length == 0 && isRefreshFirst) {
      showRefreshLoading();
    }
    super.initState();
  }

  @override
  void dispose() {
    _isShow = false;
    _isLoading = false;
    super.dispose();
  }

  showRefreshLoading() {
    Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState?.show().then((e) {});
      return true;
    });
  }

  _lockAndWait() async {
    await Future.delayed(const Duration(seconds: 1)).then((_) async {
      if (!_isLoading) return;
      return await _lockAndWait();
    });
  }
}
