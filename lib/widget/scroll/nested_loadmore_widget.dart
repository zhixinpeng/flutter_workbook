import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

class NestedLoadmoreWidget extends StatefulWidget {
  /// 下拉刷新回调
  final RefreshCallback? onRefresh;

  /// 加载更多回调
  final RefreshCallback? onLoadMore;

  /// 列表项渲染
  final IndexedWidgetBuilder itemBuilder;

  /// 头部区域
  final NestedScrollViewHeaderSliversBuilder headerSliversBuilder;

  /// 加载刷新控制器
  final LoadmoreController controller;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 刷新 Key
  final Key? refreshKey;

  const NestedLoadmoreWidget({
    required this.controller,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.headerSliversBuilder,
    Key? key,
    this.scrollController,
    this.refreshKey,
  }) : super(key: key);

  @override
  _PullRefreshLoadWidgetState createState() => _PullRefreshLoadWidgetState();
}

class _PullRefreshLoadWidgetState extends State<NestedLoadmoreWidget> {
  /// 渲染列表项
  Widget _renderItem(int index) {
    List<dynamic> data = widget.controller.dataList;

    // 数据还未加载，显示加载更多
    if (!widget.controller.isLoaded) return Container();

    // 数据为空，显示空页面
    if (data.length == 0) return _renderEmpty();

    // 列表长度为数据长度 + 一个加载更多占位
    if (index == data.length) {
      return _renderLoadMoreIndicator();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  /// 渲染加载更多指示器
  Widget _renderLoadMoreIndicator() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: widget.controller.needLoadMore
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitRotatingCircle(
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    width: 5,
                  ),
                  Text(
                    S.current.load_more_text,
                    style: TextStyle(
                      color: Color(0xFF121917),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }

  /// 渲染空页面
  Widget _renderEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Image(
              image: AssetImage(ThemeIcons.DEFAULT_USER_ICON),
              width: 70,
              height: 70,
            ),
          ),
          Container(
            child: Text(
              S.current.app_empty,
              style: ThemeTextStyle.normalText,
            ),
          ),
        ],
      ),
    );
  }

  /// 锁定状态等待数据加载完成
  _lockToAwait() async {
    await Future.delayed(const Duration(seconds: 1)).then((_) async {
      if (!widget.controller.isLoading) return;
      return await _lockToAwait();
    });
  }

  /// 刷新
  Future<Null> handleRefresh() async {
    print('nested handleRefresh');
    if (widget.controller.isLoading) {
      await _lockToAwait();
    }

    widget.controller.isLoading = true;
    await widget.onRefresh?.call();
    widget.controller.isLoading = false;
    widget.controller.isLoaded = true;
  }

  /// 加载更多
  Future<Null> handleLoadMore() async {
    print('nested handleLoadMore');
    if (widget.controller.isLoading) {
      await _lockToAwait();
    }

    widget.controller.isLoading = true;
    await widget.onLoadMore?.call();
    widget.controller.isLoading = false;
  }

  @override
  void initState() {
    /// 监听 controller 数据的变化并刷新页面
    widget.controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.refreshKey,
      onRefresh: handleRefresh,
      child: NestedScrollView(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: widget.headerSliversBuilder,
        body: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.runtimeType.toString() == 'ScrollEndNotification') {
              if (widget.controller.isLoaded && widget.controller.needLoadMore) {
                handleLoadMore();
              }
            }
            return false;
          },
          child: ListView.builder(
            itemBuilder: (_, index) {
              return _renderItem(index);
            },
            itemCount: widget.controller.dataList.length + 1,
          ),
        ),
      ),
    );
  }
}
