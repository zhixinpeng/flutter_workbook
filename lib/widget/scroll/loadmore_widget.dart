import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart' as Cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/widget/scroll/loadmore_controller.dart';

const double iosRefreshHeight = 140;
const double iosRefreshIndicatorExtent = 100;

/// 通用加载刷新控件
class LoadmoreWidget extends StatefulWidget {
  /// item 渲染
  final IndexedWidgetBuilder itemBuilder;

  /// 下拉刷新回调
  final RefreshCallback? onRefresh;

  /// 加载更多回调
  final RefreshCallback? onLoadMore;

  /// 加载刷新控制器
  final LoadmoreController controller;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 是否使用 IOS 模式
  final bool useIOS;

  const LoadmoreWidget({
    Key? key,
    required this.itemBuilder,
    required this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.scrollController,
    this.useIOS: false,
  }) : super(key: key);

  @override
  _LoadmoreWidgetState createState() => _LoadmoreWidgetState();
}

class _LoadmoreWidgetState extends State<LoadmoreWidget> {
  ScrollController? _scrollController;

  /// 渲染加载更多指示器
  Widget _renderLoadMoreIndicator() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: widget.controller.needLoadMore
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
                  Container(width: 5),
                  Text(
                    S.current.load_more_text,
                    style: TextStyle(
                      color: Color(0xFF121917),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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

  /// 渲染下拉刷新指示器
  Widget _renderRefreshIndicator(
    BuildContext context,
    Cupertino.RefreshIndicatorMode refreshState,
    double pulledExtent,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: pulledExtent > iosRefreshHeight ? pulledExtent : iosRefreshHeight,
        child: FlareActor(
          'static/file/loading_world_now.flr',
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          animation: 'Earth Moving',
        ),
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
    print('handleRefresh');
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
    print('handleLoadMore');
    if (widget.controller.isLoading) {
      await _lockToAwait();
    }

    widget.controller.isLoading = true;
    await widget.onLoadMore?.call();
    widget.controller.isLoading = false;
  }

  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();

    /// 监听 controller 数据的变化并刷新页面
    widget.controller.addListener(() {
      setState(() {});
    });

    /// 监听 scrollController 的滚动状态触发加载更多
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels == _scrollController!.position.maxScrollExtent) {
        if (widget.controller.isLoaded && widget.controller.needLoadMore) {
          handleLoadMore();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 启用 IOS 模式下的下拉刷新
    if (widget.useIOS) {
      return NotificationListener(
        child: CustomScrollView(
          controller: _scrollController,
          // 使用 BouncingScrollPhysics 是为了解决使用 Android 的 Material 风格时无法越界滚动的问题
          // 若使用的是 IOS 的 Cupertino 风格，则默认携带了此滚动特性
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            Cupertino.CupertinoSliverRefreshControl(
              refreshIndicatorExtent: iosRefreshIndicatorExtent,
              refreshTriggerPullDistance: iosRefreshHeight,
              onRefresh: handleRefresh,
              builder: _renderRefreshIndicator,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _renderItem(index);
                },
                childCount: widget.controller.dataList.length + 1,
              ),
            ),
          ],
        ),
      );
    }

    // 启用 Android 模式下的下拉刷新
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView.builder(
        // 保证 ListView 任何情况都能滚动，解决在 RefreshIndicator 的兼容问题
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _renderItem(index);
        },
        itemCount: widget.controller.dataList.length + 1,
        controller: _scrollController,
      ),
    );
  }
}
