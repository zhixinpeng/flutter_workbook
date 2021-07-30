import 'package:flutter_workbook/common/api/event_api.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

class DynamicBloc {
  final LoadmoreController controller = LoadmoreController();

  /// 列表请求页码
  int _page = 1;

  /// 获取列表数据
  List<dynamic> get dataList => controller.dataList;

  /// 获取列表数据长度
  int get dataLength => dataList.length;

  /// 更新是否需要刷新功能
  changeNeedRefresh(bool needRefresh) {
    controller.needRefresh = needRefresh;
  }

  /// 更新是否需要加载更多功能
  changeNeedLoadMore(bool needLoadMore) {
    controller.needLoadMore = needLoadMore;
  }

  /// 判断是否需要加载更多
  checkNeedLoadMore(ResultData? res) {
    return res != null && res.data != null && res.data.length == Config.PAGE_SIZE;
  }

  /// 刷新列表数据
  refreshData(ResultData? res) {
    if (res != null) {
      controller.dataList = res.data;
    }
  }

  /// 加载列表数据
  loadMoreData(ResultData? res) {
    if (res != null) {
      controller.addList(res.data);
    }
  }

  /// 重置页码
  pageReset() => _page = 1;

  /// 增加页码
  pageIncrease() => _page++;

  doNext(ResultData? res) async {
    if (res?.next != null) {
      print('need do next');
    }
  }

  /// 发起刷新请求
  requestRefresh({String? username, next: true}) async {
    pageReset();

    var res = await EventApi.getEventReceived(username: username, page: _page);
    changeNeedLoadMore(checkNeedLoadMore(res));
    refreshData(res);

    if (next) {
      await doNext(res);
    }

    return res;
  }

  /// 发起加载更多请求
  requestLoadMore({String? username}) async {
    pageIncrease();
    var res = await EventApi.getEventReceived(username: username, page: _page);
    changeNeedLoadMore(checkNeedLoadMore(res));
    loadMoreData(res);
  }

  dispose() {
    controller.dispose();
  }
}
