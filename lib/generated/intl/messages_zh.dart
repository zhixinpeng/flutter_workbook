// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_back_tip": MessageLookupByLibrary.simpleMessage("确定要退出应用？"),
        "app_cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "app_close": MessageLookupByLibrary.simpleMessage("关闭"),
        "app_empty": MessageLookupByLibrary.simpleMessage("目前什么也没有哟"),
        "app_licenses": MessageLookupByLibrary.simpleMessage("协议"),
        "app_name": MessageLookupByLibrary.simpleMessage("GithubApp"),
        "app_not_new_version": MessageLookupByLibrary.simpleMessage("当前没有新版本"),
        "app_ok": MessageLookupByLibrary.simpleMessage("确定"),
        "app_version": MessageLookupByLibrary.simpleMessage("版本"),
        "app_version_title": MessageLookupByLibrary.simpleMessage("版本更新"),
        "github_refused": MessageLookupByLibrary.simpleMessage(
            "Github Api 出现异常[Connection refused]，建议换个网络环境或者稍后再试"),
        "home_about": MessageLookupByLibrary.simpleMessage("关于"),
        "home_change_language": MessageLookupByLibrary.simpleMessage("语言切换"),
        "home_change_theme": MessageLookupByLibrary.simpleMessage("切换主题"),
        "home_check_update": MessageLookupByLibrary.simpleMessage("检测更新"),
        "home_dynamic": MessageLookupByLibrary.simpleMessage("动态"),
        "home_history": MessageLookupByLibrary.simpleMessage("阅读历史"),
        "home_language_default": MessageLookupByLibrary.simpleMessage("默认"),
        "home_language_en": MessageLookupByLibrary.simpleMessage("English"),
        "home_language_zh": MessageLookupByLibrary.simpleMessage("中文"),
        "home_my": MessageLookupByLibrary.simpleMessage("我的"),
        "home_reply": MessageLookupByLibrary.simpleMessage("问题反馈"),
        "home_theme_1": MessageLookupByLibrary.simpleMessage("主题1"),
        "home_theme_2": MessageLookupByLibrary.simpleMessage("主题2"),
        "home_theme_3": MessageLookupByLibrary.simpleMessage("主题3"),
        "home_theme_4": MessageLookupByLibrary.simpleMessage("主题4"),
        "home_theme_5": MessageLookupByLibrary.simpleMessage("主题5"),
        "home_theme_6": MessageLookupByLibrary.simpleMessage("主题6"),
        "home_theme_default": MessageLookupByLibrary.simpleMessage("默认主题"),
        "home_trend": MessageLookupByLibrary.simpleMessage("趋势"),
        "home_user_info": MessageLookupByLibrary.simpleMessage("个人信息"),
        "issue_close": MessageLookupByLibrary.simpleMessage("关闭"),
        "issue_commit_issue": MessageLookupByLibrary.simpleMessage("提交Issue"),
        "issue_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "issue_edit_issue": MessageLookupByLibrary.simpleMessage("编译Issue"),
        "issue_edit_issue_commit": MessageLookupByLibrary.simpleMessage("编译回复"),
        "issue_edit_issue_content_not_be_null":
            MessageLookupByLibrary.simpleMessage("内容不能为空"),
        "issue_edit_issue_content_tip":
            MessageLookupByLibrary.simpleMessage("请输入内容"),
        "issue_edit_issue_copy_commit":
            MessageLookupByLibrary.simpleMessage("复制"),
        "issue_edit_issue_delete_commit":
            MessageLookupByLibrary.simpleMessage("删除"),
        "issue_edit_issue_edit_commit":
            MessageLookupByLibrary.simpleMessage("编辑"),
        "issue_edit_issue_title_not_be_null":
            MessageLookupByLibrary.simpleMessage("标题不能为空"),
        "issue_edit_issue_title_tip":
            MessageLookupByLibrary.simpleMessage("请输入标题"),
        "issue_lock": MessageLookupByLibrary.simpleMessage("锁定"),
        "issue_open": MessageLookupByLibrary.simpleMessage("打开"),
        "issue_reply": MessageLookupByLibrary.simpleMessage("回复"),
        "issue_reply_issue": MessageLookupByLibrary.simpleMessage("回复Issue"),
        "issue_unlock": MessageLookupByLibrary.simpleMessage("解锁"),
        "load_more_not": MessageLookupByLibrary.simpleMessage("没有更多数据"),
        "load_more_text": MessageLookupByLibrary.simpleMessage("正在加载更多"),
        "loading_text": MessageLookupByLibrary.simpleMessage("努力加载中···"),
        "login_deprecated": MessageLookupByLibrary.simpleMessage(
            "账号密码登陆的 API 将被 Github 弃用，建议使用尝试使用安全登陆。"),
        "login_out": MessageLookupByLibrary.simpleMessage("退出登录"),
        "login_password_hint_text":
            MessageLookupByLibrary.simpleMessage("请输入密码"),
        "login_success": MessageLookupByLibrary.simpleMessage("登录成功"),
        "login_text": MessageLookupByLibrary.simpleMessage("账号登录"),
        "login_username_hint_text":
            MessageLookupByLibrary.simpleMessage("github用户名，请不要用邮箱"),
        "network_error": MessageLookupByLibrary.simpleMessage("网络错误"),
        "network_error_401": MessageLookupByLibrary.simpleMessage(
            "[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]"),
        "network_error_403": MessageLookupByLibrary.simpleMessage("403权限错误"),
        "network_error_404": MessageLookupByLibrary.simpleMessage("404错误"),
        "network_error_422": MessageLookupByLibrary.simpleMessage(
            "请求实体异常，请确保 Github ClientId 、账号秘密等信息正确。"),
        "network_error_timeout": MessageLookupByLibrary.simpleMessage("请求超时"),
        "network_error_unknown": MessageLookupByLibrary.simpleMessage("其他异常"),
        "nothing_now": MessageLookupByLibrary.simpleMessage("目前什么都没有。"),
        "notify_readed": MessageLookupByLibrary.simpleMessage("已读"),
        "notify_status": MessageLookupByLibrary.simpleMessage("状态"),
        "notify_tab_all": MessageLookupByLibrary.simpleMessage("所有"),
        "notify_tab_part": MessageLookupByLibrary.simpleMessage("参与"),
        "notify_tab_unread": MessageLookupByLibrary.simpleMessage("未读"),
        "notify_title": MessageLookupByLibrary.simpleMessage("通知"),
        "notify_type": MessageLookupByLibrary.simpleMessage("类型"),
        "notify_unread": MessageLookupByLibrary.simpleMessage("未读"),
        "oauth_text": MessageLookupByLibrary.simpleMessage("安全登陆"),
        "option_copy": MessageLookupByLibrary.simpleMessage("复制链接"),
        "option_share": MessageLookupByLibrary.simpleMessage("分享"),
        "option_share_copy_success":
            MessageLookupByLibrary.simpleMessage("已经复制到粘贴板"),
        "option_share_title":
            MessageLookupByLibrary.simpleMessage("分享自GitHubFlutter： "),
        "option_web": MessageLookupByLibrary.simpleMessage("浏览器打开"),
        "option_web_launcher_error":
            MessageLookupByLibrary.simpleMessage("url异常"),
        "release_tab_release": MessageLookupByLibrary.simpleMessage("版本"),
        "release_tab_tag": MessageLookupByLibrary.simpleMessage("标记"),
        "repos_all_issue_count":
            MessageLookupByLibrary.simpleMessage("所有Issue数："),
        "repos_close_issue_count":
            MessageLookupByLibrary.simpleMessage("关闭Issue数："),
        "repos_create_at": MessageLookupByLibrary.simpleMessage("创建于 "),
        "repos_fork_at": MessageLookupByLibrary.simpleMessage("Fork于 "),
        "repos_issue_search": MessageLookupByLibrary.simpleMessage("搜索"),
        "repos_last_commit": MessageLookupByLibrary.simpleMessage("最后提交于 "),
        "repos_no_support_issue":
            MessageLookupByLibrary.simpleMessage("该项目没有开启 Issue"),
        "repos_open_issue_count":
            MessageLookupByLibrary.simpleMessage("开启Issue数："),
        "repos_option_branch": MessageLookupByLibrary.simpleMessage("分支"),
        "repos_option_release": MessageLookupByLibrary.simpleMessage("版本"),
        "repos_tab_activity": MessageLookupByLibrary.simpleMessage("动态"),
        "repos_tab_commits": MessageLookupByLibrary.simpleMessage("提交"),
        "repos_tab_file": MessageLookupByLibrary.simpleMessage("文件"),
        "repos_tab_info": MessageLookupByLibrary.simpleMessage("动态"),
        "repos_tab_issue": MessageLookupByLibrary.simpleMessage("ISSUE"),
        "repos_tab_issue_all": MessageLookupByLibrary.simpleMessage("所有"),
        "repos_tab_issue_closed": MessageLookupByLibrary.simpleMessage("关闭"),
        "repos_tab_issue_open": MessageLookupByLibrary.simpleMessage("打开"),
        "repos_tab_readme": MessageLookupByLibrary.simpleMessage("详情"),
        "search_language": MessageLookupByLibrary.simpleMessage("语言"),
        "search_sort": MessageLookupByLibrary.simpleMessage("排序"),
        "search_tab_repos": MessageLookupByLibrary.simpleMessage("仓库"),
        "search_tab_user": MessageLookupByLibrary.simpleMessage("用户"),
        "search_title": MessageLookupByLibrary.simpleMessage("搜索"),
        "search_type": MessageLookupByLibrary.simpleMessage("类型"),
        "switch_language": MessageLookupByLibrary.simpleMessage("切换语言"),
        "trend_all": MessageLookupByLibrary.simpleMessage("全部"),
        "trend_day": MessageLookupByLibrary.simpleMessage("今日"),
        "trend_month": MessageLookupByLibrary.simpleMessage("本月"),
        "trend_user_title": MessageLookupByLibrary.simpleMessage("中国用户趋势"),
        "trend_week": MessageLookupByLibrary.simpleMessage("本周"),
        "user_create_at": MessageLookupByLibrary.simpleMessage("创建于："),
        "user_dynamic_group": MessageLookupByLibrary.simpleMessage("组织成员"),
        "user_dynamic_title": MessageLookupByLibrary.simpleMessage("个人动态"),
        "user_focus": MessageLookupByLibrary.simpleMessage("已关注"),
        "user_focus_no_support":
            MessageLookupByLibrary.simpleMessage("不支持关注组织。"),
        "user_orgs_title": MessageLookupByLibrary.simpleMessage("所在组织"),
        "user_profile_email": MessageLookupByLibrary.simpleMessage("邮箱"),
        "user_profile_info": MessageLookupByLibrary.simpleMessage("简介"),
        "user_profile_link": MessageLookupByLibrary.simpleMessage("链接"),
        "user_profile_location": MessageLookupByLibrary.simpleMessage("位置"),
        "user_profile_name": MessageLookupByLibrary.simpleMessage("名字"),
        "user_profile_org": MessageLookupByLibrary.simpleMessage("公司"),
        "user_tab_fans": MessageLookupByLibrary.simpleMessage("粉丝"),
        "user_tab_focus": MessageLookupByLibrary.simpleMessage("关注"),
        "user_tab_honor": MessageLookupByLibrary.simpleMessage("荣耀"),
        "user_tab_repos": MessageLookupByLibrary.simpleMessage("仓库"),
        "user_tab_star": MessageLookupByLibrary.simpleMessage("星标"),
        "user_un_focus": MessageLookupByLibrary.simpleMessage("关注"),
        "welcome_message":
            MessageLookupByLibrary.simpleMessage("Welcome To Flutter")
      };
}
