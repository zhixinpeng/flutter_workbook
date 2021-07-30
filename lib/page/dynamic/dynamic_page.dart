import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_workbook/model/Event.dart';
import 'package:flutter_workbook/page/dynamic/dynamic_bloc.dart';
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
    with AutomaticKeepAliveClientMixin<DynamicPage>, WidgetsBindingObserver {
  /// 控制列表滚动和监听
  final ScrollController scrollController = ScrollController();

  /// 页面关于刷新和加载的逻辑集合
  final DynamicBloc dynamicBloc = DynamicBloc();

  /// 控制页面刷新的标记
  final GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey<RefreshIndicatorState>();

  /// 控制页面是否禁用点击
  bool _ingoring = false;

  /// 自动下拉刷新页面
  _showRefreshLoading() {
    Future.delayed(const Duration(milliseconds: 500), () {
      scrollController.animateTo(
        -141,
        duration: Duration(milliseconds: 600),
        curve: Curves.linear,
      );
      return true;
    });
  }

  /// 请求下拉刷新
  Future<void> _requestRefresh() async {
    await dynamicBloc.requestRefresh(username: _getStore().state.userInfo?.login);
    setState(() {
      _ingoring = false;
    });
  }

  /// 请求上拉加载
  Future<void> _requestLoadMore() async {
    await dynamicBloc.requestLoadMore(username: _getStore().state.userInfo?.login);
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
    if (dynamicBloc.dataLength == 0) {
      dynamicBloc.changeNeedRefresh(false);
      _showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _showRefreshLoading();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AutomaticKeepAliveClientMixin
    super.build(context);
    return IgnorePointer(
      ignoring: _ingoring,
      child: LoadmoreWidget(
        controller: dynamicBloc.controller,
        itemBuilder: (context, index) {
          return _renderEventItem(dynamicBloc.dataList[index]);
        },
        onRefresh: _requestRefresh,
        onLoadMore: _requestLoadMore,
        refreshKey: refreshIndicator,
        scrollController: scrollController,
        useIOS: true,
      ),
    );
  }
}
