import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

class NestedLoadmoreWidget extends StatefulWidget {
  /// 下拉刷新回调
  final RefreshCallback onRefresh;

  /// 加载更多回调
  final RefreshCallback onLoadMore;

  /// 列表项渲染
  final IndexedWidgetBuilder itemBuilder;

  /// 头部区域
  final NestedScrollViewHeaderSliversBuilder headerSliversBuilder;

  /// 加载刷新控制器
  final LoadmoreController controller;

  /// 滚动控制器
  final ScrollController? scrollController;

  final Key? refreshKey;

  const NestedLoadmoreWidget({
    required this.controller,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.headerSliversBuilder,
    Key? key,
    this.refreshKey,
    this.scrollController,
  }) : super(key: key);

  @override
  _PullRefreshLoadWidgetState createState() => _PullRefreshLoadWidgetState();
}

class _PullRefreshLoadWidgetState extends State<NestedLoadmoreWidget> {
  /// 根据配置状态返回实际列表数量
  int _getListCount() {
    bool needRefresh = widget.controller.needRefresh;
    int length = widget.controller.dataList.length;

    if (needRefresh) {
      return length > 0 ? length + 2 : length + 1;
    } else {
      if (length == 0) return 1;
      return length > 0 ? length + 1 : length;
    }
  }

  /// 渲染列表项
  Widget _renderItem(int index) {
    bool needRefresh = widget.controller.needRefresh;
    List<dynamic> data = widget.controller.dataList;

    if (!needRefresh && index == data.length && data.length != 0) {
      // 如果不需要头部，并且有数据，当 index 等于数据长度时，渲染加载更多 Item
      return _buildProgressIndicator();
    } else if (widget.controller.needRefresh &&
        index == _getListCount() - 1 &&
        widget.controller.dataList.length != 0) {
      return _buildProgressIndicator();
    } else if (!widget.controller.needRefresh && widget.controller.dataList.length == 0) {
      // 如果不需要头部，并且无数据，渲染空页面
      return _buildEmpty();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  /// 上拉加载更多
  Widget _buildProgressIndicator() {
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

  /// 空页面
  Widget _buildEmpty() {
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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.refreshKey,
      onRefresh: widget.onRefresh,
      child: NestedScrollView(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: widget.headerSliversBuilder,
        body: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
              if (widget.controller.needLoadMore) {
                widget.onLoadMore.call();
              }
            }
            return false;
          },
          child: ListView.builder(
            itemBuilder: (_, index) {
              return _renderItem(index);
            },
            itemCount: _getListCount(),
          ),
        ),
      ),
    );
  }
}
