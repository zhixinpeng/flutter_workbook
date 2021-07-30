import 'package:flutter/material.dart';

/// 滚动页面用于控制加载和刷新的控制器
class LoadmoreController extends ChangeNotifier {
  /// 数据源
  List _dataList = [];

  /// 是否需要加载更多
  bool _needLoadMore = true;

  /// 是否需要刷新
  bool _needRefresh = false;

  /// 是否处于加载中
  bool isLoading = false;

  /// 是否已经完成加载
  bool isLoaded = false;

  /// 获取数据源
  List get dataList => _dataList;

  /// 设置数据源
  set dataList(List? value) {
    _dataList.clear();
    if (value != null) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  /// 往数据源添加数据
  addList(List? value) {
    if (value != null) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  /// 获取是否需要加载更多
  bool get needLoadMore => _needLoadMore;

  /// 设置是否需要加载更多
  set needLoadMore(bool value) {
    _needLoadMore = value;
    notifyListeners();
  }

  /// 获取是否需要刷新
  bool get needRefresh => _needRefresh;

  /// 设置是否需要刷新
  set needRefresh(bool value) {
    _needRefresh = value;
    notifyListeners();
  }
}
