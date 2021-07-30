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

  /// 刷新 KEY
  final Key? refreshKey;

  const LoadmoreWidget({
    Key? key,
    required this.itemBuilder,
    required this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.scrollController,
    this.useIOS: false,
    this.refreshKey,
  }) : super(key: key);

  @override
  _LoadmoreWidgetState createState() => _LoadmoreWidgetState();
}

class _LoadmoreWidgetState extends State<LoadmoreWidget> {
  ScrollController? _scrollController;

  bool _isRefreshing = false;

  bool _isLoadingMore = false;

  /// 根据配置状态返回实际列表元素数量
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

  /// 渲染加载更多提示
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
    bool needRefresh = widget.controller.needRefresh;
    List<dynamic> data = widget.controller.dataList;

    // 不需要刷新且 index 等于数据长度、需要头部且 index 等于实际渲染长度 - 1时，需要显示加载更多
    bool showIndicator = (!needRefresh && index == data.length) || (needRefresh && index == _getListCount() - 1);

    // 数据还未加载，显示加载更多
    if (!widget.controller.isLoaded) {
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - 100,
        child: _renderLoadMoreIndicator(),
      );
    }

    // 数据已加载，根据配置和数据显示对应内容
    if (showIndicator && data.length != 0) {
      // 数据不为空时显示加载更多提示
      return _renderLoadMoreIndicator();
    } else if (!needRefresh && data.length == 0) {
      // 不需要头部且数据为空时，显示空页面
      return _renderEmpty();
    } else {
      // 其他情况正常显示列表元素
      return widget.itemBuilder(context, index);
    }
  }

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

  _lockToAwait() async {
    await Future.delayed(const Duration(seconds: 1)).then((_) async {
      if (!widget.controller.isLoading) return;
      return await _lockToAwait();
    });
  }

  @protected
  Future<Null> handleRefresh() async {
    print('handleRefresh');
    if (widget.controller.isLoading) {
      if (_isRefreshing) return null;
      await _lockToAwait();
    }

    widget.controller.isLoading = true;
    _isRefreshing = true;
    await widget.onRefresh?.call();
    _isRefreshing = false;
    widget.controller.isLoading = false;
    widget.controller.isLoaded = true;
  }

  @protected
  Future<Null> handleLoadMore() async {
    print('handleLoadMore');
    if (widget.controller.isLoading) {
      if (_isLoadingMore) return;
      await _lockToAwait();
    }

    widget.controller.isLoading = true;
    _isLoadingMore = true;
    await widget.onLoadMore?.call();
    _isLoadingMore = false;
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
        if (widget.controller.needLoadMore) {
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
                childCount: _getListCount(),
              ),
            ),
          ],
        ),
      );
    }

    // 启用 Android 模式下的下拉刷新
    return RefreshIndicator(
      // GlobalKey 用于外部获取 RefreshIndicator 的 State，做显示刷新
      key: widget.refreshKey,
      onRefresh: handleRefresh,
      child: ListView.builder(
        // 保证 ListView 任何情况都能滚动，解决在 RefreshIndicator 的兼容问题
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _renderItem(index);
        },
        itemCount: _getListCount(),
        controller: _scrollController,
      ),
    );
  }
}
