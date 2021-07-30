import 'package:flutter_workbook/common/api/index.dart';
import 'package:flutter_workbook/common/api/result_data.dart';
import 'package:flutter_workbook/common/net/address.dart';
import 'package:flutter_workbook/model/Event.dart';

class EventApi {
  /// 获取用户事件
  static getEvent(username, {page: 0}) async {
    String url = Address.getEvent(username) + Address.getPageParams('?', page);
    ResultData<dynamic>? res = await httpManager.fetch(url, null, null, null);
    if (res != null && res.result) {
      List<Event> list = [];
      var data = res.data;
      if (data == null || data.length == 0) {
        return ResultData(null, true);
      }
      for (var i = 0; i < data.length; i++) {
        list.add(Event.fromJson(data[i]));
      }
      return ResultData(list, true);
    } else {
      return ResultData(null, false);
    }
  }

  /// 获取接收的事件
  static getEventReceived({String? username, int page: 1}) async {
    if (username == null) return;
    String url = Address.getEventReceived(username) + Address.getPageParams('?', page);
    ResultData<dynamic>? res = await httpManager.fetch(url, null, null, null);
    if (res != null && res.result) {
      List<Event> list = [];
      dynamic data = res.data;
      if (data == null || data.length == 0) return ResultData(null, true);
      for (var i = 0; i < data.length; i++) {
        list.add(Event.fromJson(data[i]));
      }
      return ResultData(list, true);
    } else {
      return ResultData(null, false);
    }
  }
}
