import 'package:flutter_workbook/common/config/config.dart';
import 'package:flutter_workbook/common/config/ignoreConfig.dart';

/// 请求地址数据
class Address {
  static const String host = "https://api.github.com/";
  static const String hostWeb = "https://github.com/";
  static const String graphicHost = 'https://ghchart.rshah.org/';

  /// 获取授权登录地址
  static getOAuthUrl() {
    return "https://github.com/login/oauth/authorize?client_id=${GithubConfig.CLIENT_ID}&state=app&redirect_uri=pengzhixin://authed";
  }

  /// 我的用户信息
  static getMyUserInfo() {
    return '${host}user';
  }

  /// 用户信息
  static getUserInfo(username) {
    return '${host}users/$username';
  }

  /// 用户 Star 数目
  static getUserStar(username, sort) {
    sort ??= 'updated';

    return '${host}users/$username/starred?sort=$sort';
  }

  /// 用户组织
  static getUserOrganization(username) {
    return '${host}users/$username/orgs';
  }

  /// 处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    return '${tab}page=$page&per_page=$pageSize';
  }

  /// 组成成员
  static getMember(orgs) {
    return '${host}orgs/$orgs/members';
  }

  /// 用户相关的事件信息
  static getEvent(username) {
    return '${host}users/$username/events';
  }

  /// 用户接收到的事件信息
  static getEventReceived(username) {
    return '${host}users/$username/received_events';
  }
}
