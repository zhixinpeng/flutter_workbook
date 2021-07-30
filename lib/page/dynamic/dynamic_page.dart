import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/model/Event.dart';
import 'package:flutter_workbook/page/dynamic/dynamic_mixin.dart';
import 'package:flutter_workbook/redux/redux_state.dart';
import 'package:flutter_workbook/widget/event_item_widget.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_widget.dart';
import 'package:redux/redux.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  DynamicPageState createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin<DynamicPage>, DynamicMixin<DynamicPage>, WidgetsBindingObserver {
  /// 控制页面是否禁用点击
  bool _ingoring = true;

  /// 请求下拉刷新
  Future<void> _requestRefresh() async {
    await requestRefresh(username: _getStore().state.userInfo?.login);
    setState(() {
      _ingoring = false;
    });
  }

  /// 请求上拉加载
  Future<void> _requestLoadMore() async {
    await requestLoadMore(username: _getStore().state.userInfo?.login);
  }

  /// 渲染列表项
  Widget _renderEventItem(Event event) {
    EventViewModel eventViewModel = EventViewModel.fromEventMap(event);
    return EventItemWidget(
      eventViewModel,
      onPressed: () {},
    );
  }

  /// 获取全局状态仓库
  Store<ReduxState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // 监听生命周期，主要用于判断页面 resumed 的时候触发刷新
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // 初次进入数据为空时加载数据
    if (dataLength == 0) showRefreshLoading();
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) showRefreshLoading();
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    // AutomaticKeepAliveClientMixin
    super.build(context);

    return IgnorePointer(
      ignoring: _ingoring,
      child: LoadmoreWidget(
        controller: controller,
        itemBuilder: (context, index) {
          return _renderEventItem(dataList[index]);
        },
        onRefresh: _requestRefresh,
        onLoadMore: _requestLoadMore,
        scrollController: scrollController,
        useIOS: true,
      ),
    );
  }
}
