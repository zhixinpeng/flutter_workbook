// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To Flutter`
  String get welcome_message {
    return Intl.message(
      'Welcome To Flutter',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `GithubApp`
  String get app_name {
    return Intl.message(
      'GithubApp',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get app_ok {
    return Intl.message(
      'ok',
      name: 'app_ok',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get app_cancel {
    return Intl.message(
      'cancel',
      name: 'app_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Empty(oﾟ▽ﾟ)o`
  String get app_empty {
    return Intl.message(
      'Empty(oﾟ▽ﾟ)o',
      name: 'app_empty',
      desc: '',
      args: [],
    );
  }

  /// `licenses`
  String get app_licenses {
    return Intl.message(
      'licenses',
      name: 'app_licenses',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get app_close {
    return Intl.message(
      'close',
      name: 'app_close',
      desc: '',
      args: [],
    );
  }

  /// `version`
  String get app_version {
    return Intl.message(
      'version',
      name: 'app_version',
      desc: '',
      args: [],
    );
  }

  /// `Exit？`
  String get app_back_tip {
    return Intl.message(
      'Exit？',
      name: 'app_back_tip',
      desc: '',
      args: [],
    );
  }

  /// `No new version.`
  String get app_not_new_version {
    return Intl.message(
      'No new version.',
      name: 'app_not_new_version',
      desc: '',
      args: [],
    );
  }

  /// `Update Version`
  String get app_version_title {
    return Intl.message(
      'Update Version',
      name: 'app_version_title',
      desc: '',
      args: [],
    );
  }

  /// `Nothing`
  String get nothing_now {
    return Intl.message(
      'Nothing',
      name: 'nothing_now',
      desc: '',
      args: [],
    );
  }

  /// `Loading···`
  String get loading_text {
    return Intl.message(
      'Loading···',
      name: 'loading_text',
      desc: '',
      args: [],
    );
  }

  /// `browser`
  String get option_web {
    return Intl.message(
      'browser',
      name: 'option_web',
      desc: '',
      args: [],
    );
  }

  /// `copy`
  String get option_copy {
    return Intl.message(
      'copy',
      name: 'option_copy',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get option_share {
    return Intl.message(
      'share',
      name: 'option_share',
      desc: '',
      args: [],
    );
  }

  /// `url error`
  String get option_web_launcher_error {
    return Intl.message(
      'url error',
      name: 'option_web_launcher_error',
      desc: '',
      args: [],
    );
  }

  /// `share form GSYGitHubFlutter： `
  String get option_share_title {
    return Intl.message(
      'share form GSYGitHubFlutter： ',
      name: 'option_share_title',
      desc: '',
      args: [],
    );
  }

  /// `Copy Success`
  String get option_share_copy_success {
    return Intl.message(
      'Copy Success',
      name: 'option_share_copy_success',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_text {
    return Intl.message(
      'Login',
      name: 'login_text',
      desc: '',
      args: [],
    );
  }

  /// `OAuth`
  String get oauth_text {
    return Intl.message(
      'OAuth',
      name: 'oauth_text',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get login_out {
    return Intl.message(
      'Logout',
      name: 'login_out',
      desc: '',
      args: [],
    );
  }

  /// `The API via password authentication will remove on November 13, 2020 by Github`
  String get login_deprecated {
    return Intl.message(
      'The API via password authentication will remove on November 13, 2020 by Github',
      name: 'login_deprecated',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get home_reply {
    return Intl.message(
      'Feedback',
      name: 'home_reply',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get home_change_language {
    return Intl.message(
      'Language',
      name: 'home_change_language',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get home_about {
    return Intl.message(
      'About',
      name: 'home_about',
      desc: '',
      args: [],
    );
  }

  /// `CheckUpdate`
  String get home_check_update {
    return Intl.message(
      'CheckUpdate',
      name: 'home_check_update',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get home_history {
    return Intl.message(
      'History',
      name: 'home_history',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get home_user_info {
    return Intl.message(
      'Profile',
      name: 'home_user_info',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get home_change_theme {
    return Intl.message(
      'Theme',
      name: 'home_change_theme',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get home_language_default {
    return Intl.message(
      'Default',
      name: 'home_language_default',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get home_language_zh {
    return Intl.message(
      '中文',
      name: 'home_language_zh',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get home_language_en {
    return Intl.message(
      'English',
      name: 'home_language_en',
      desc: '',
      args: [],
    );
  }

  /// `select language`
  String get switch_language {
    return Intl.message(
      'select language',
      name: 'switch_language',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get home_theme_default {
    return Intl.message(
      'Default',
      name: 'home_theme_default',
      desc: '',
      args: [],
    );
  }

  /// `Theme1`
  String get home_theme_1 {
    return Intl.message(
      'Theme1',
      name: 'home_theme_1',
      desc: '',
      args: [],
    );
  }

  /// `Theme2`
  String get home_theme_2 {
    return Intl.message(
      'Theme2',
      name: 'home_theme_2',
      desc: '',
      args: [],
    );
  }

  /// `Theme3`
  String get home_theme_3 {
    return Intl.message(
      'Theme3',
      name: 'home_theme_3',
      desc: '',
      args: [],
    );
  }

  /// `Theme4`
  String get home_theme_4 {
    return Intl.message(
      'Theme4',
      name: 'home_theme_4',
      desc: '',
      args: [],
    );
  }

  /// `Theme5`
  String get home_theme_5 {
    return Intl.message(
      'Theme5',
      name: 'home_theme_5',
      desc: '',
      args: [],
    );
  }

  /// `Theme6`
  String get home_theme_6 {
    return Intl.message(
      'Theme6',
      name: 'home_theme_6',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get login_username_hint_text {
    return Intl.message(
      'username',
      name: 'login_username_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get login_password_hint_text {
    return Intl.message(
      'password',
      name: 'login_password_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get login_success {
    return Intl.message(
      'Login Success',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `Http 401`
  String get network_error_401 {
    return Intl.message(
      'Http 401',
      name: 'network_error_401',
      desc: '',
      args: [],
    );
  }

  /// `Http 403`
  String get network_error_403 {
    return Intl.message(
      'Http 403',
      name: 'network_error_403',
      desc: '',
      args: [],
    );
  }

  /// `Http 404`
  String get network_error_404 {
    return Intl.message(
      'Http 404',
      name: 'network_error_404',
      desc: '',
      args: [],
    );
  }

  /// `Request Body Error，Please Check Github ClientId or Account/PW`
  String get network_error_422 {
    return Intl.message(
      'Request Body Error，Please Check Github ClientId or Account/PW',
      name: 'network_error_422',
      desc: '',
      args: [],
    );
  }

  /// `Http timeout`
  String get network_error_timeout {
    return Intl.message(
      'Http timeout',
      name: 'network_error_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Http unknown error`
  String get network_error_unknown {
    return Intl.message(
      'Http unknown error',
      name: 'network_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `network error`
  String get network_error {
    return Intl.message(
      'network error',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Github Api Error[OS Error: Connection refused]. Please switch networks or try again later `
  String get github_refused {
    return Intl.message(
      'Github Api Error[OS Error: Connection refused]. Please switch networks or try again later ',
      name: 'github_refused',
      desc: '',
      args: [],
    );
  }

  /// `nothing`
  String get load_more_not {
    return Intl.message(
      'nothing',
      name: 'load_more_not',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get load_more_text {
    return Intl.message(
      'loading',
      name: 'load_more_text',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic`
  String get home_dynamic {
    return Intl.message(
      'Dynamic',
      name: 'home_dynamic',
      desc: '',
      args: [],
    );
  }

  /// `Trend`
  String get home_trend {
    return Intl.message(
      'Trend',
      name: 'home_trend',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get home_my {
    return Intl.message(
      'My',
      name: 'home_my',
      desc: '',
      args: [],
    );
  }

  /// `China User Trend`
  String get trend_user_title {
    return Intl.message(
      'China User Trend',
      name: 'trend_user_title',
      desc: '',
      args: [],
    );
  }

  /// `today`
  String get trend_day {
    return Intl.message(
      'today',
      name: 'trend_day',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get trend_week {
    return Intl.message(
      'week',
      name: 'trend_week',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get trend_month {
    return Intl.message(
      'month',
      name: 'trend_month',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get trend_all {
    return Intl.message(
      'all',
      name: 'trend_all',
      desc: '',
      args: [],
    );
  }

  /// `repos`
  String get user_tab_repos {
    return Intl.message(
      'repos',
      name: 'user_tab_repos',
      desc: '',
      args: [],
    );
  }

  /// `fan`
  String get user_tab_fans {
    return Intl.message(
      'fan',
      name: 'user_tab_fans',
      desc: '',
      args: [],
    );
  }

  /// `focus`
  String get user_tab_focus {
    return Intl.message(
      'focus',
      name: 'user_tab_focus',
      desc: '',
      args: [],
    );
  }

  /// `star`
  String get user_tab_star {
    return Intl.message(
      'star',
      name: 'user_tab_star',
      desc: '',
      args: [],
    );
  }

  /// `honor`
  String get user_tab_honor {
    return Intl.message(
      'honor',
      name: 'user_tab_honor',
      desc: '',
      args: [],
    );
  }

  /// `Members,`
  String get user_dynamic_group {
    return Intl.message(
      'Members,',
      name: 'user_dynamic_group',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic`
  String get user_dynamic_title {
    return Intl.message(
      'Dynamic',
      name: 'user_dynamic_title',
      desc: '',
      args: [],
    );
  }

  /// `Focused`
  String get user_focus {
    return Intl.message(
      'Focused',
      name: 'user_focus',
      desc: '',
      args: [],
    );
  }

  /// `Focus`
  String get user_un_focus {
    return Intl.message(
      'Focus',
      name: 'user_un_focus',
      desc: '',
      args: [],
    );
  }

  /// `Not Support。`
  String get user_focus_no_support {
    return Intl.message(
      'Not Support。',
      name: 'user_focus_no_support',
      desc: '',
      args: [],
    );
  }

  /// `Create at：`
  String get user_create_at {
    return Intl.message(
      'Create at：',
      name: 'user_create_at',
      desc: '',
      args: [],
    );
  }

  /// `organization`
  String get user_orgs_title {
    return Intl.message(
      'organization',
      name: 'user_orgs_title',
      desc: '',
      args: [],
    );
  }

  /// `readme`
  String get repos_tab_readme {
    return Intl.message(
      'readme',
      name: 'repos_tab_readme',
      desc: '',
      args: [],
    );
  }

  /// `info`
  String get repos_tab_info {
    return Intl.message(
      'info',
      name: 'repos_tab_info',
      desc: '',
      args: [],
    );
  }

  /// `file`
  String get repos_tab_file {
    return Intl.message(
      'file',
      name: 'repos_tab_file',
      desc: '',
      args: [],
    );
  }

  /// `issue`
  String get repos_tab_issue {
    return Intl.message(
      'issue',
      name: 'repos_tab_issue',
      desc: '',
      args: [],
    );
  }

  /// `activity`
  String get repos_tab_activity {
    return Intl.message(
      'activity',
      name: 'repos_tab_activity',
      desc: '',
      args: [],
    );
  }

  /// `commits`
  String get repos_tab_commits {
    return Intl.message(
      'commits',
      name: 'repos_tab_commits',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get repos_tab_issue_all {
    return Intl.message(
      'all',
      name: 'repos_tab_issue_all',
      desc: '',
      args: [],
    );
  }

  /// `open`
  String get repos_tab_issue_open {
    return Intl.message(
      'open',
      name: 'repos_tab_issue_open',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get repos_tab_issue_closed {
    return Intl.message(
      'close',
      name: 'repos_tab_issue_closed',
      desc: '',
      args: [],
    );
  }

  /// `release`
  String get repos_option_release {
    return Intl.message(
      'release',
      name: 'repos_option_release',
      desc: '',
      args: [],
    );
  }

  /// `branch`
  String get repos_option_branch {
    return Intl.message(
      'branch',
      name: 'repos_option_branch',
      desc: '',
      args: [],
    );
  }

  /// `Fork at `
  String get repos_fork_at {
    return Intl.message(
      'Fork at ',
      name: 'repos_fork_at',
      desc: '',
      args: [],
    );
  }

  /// `create at `
  String get repos_create_at {
    return Intl.message(
      'create at ',
      name: 'repos_create_at',
      desc: '',
      args: [],
    );
  }

  /// `last commit at `
  String get repos_last_commit {
    return Intl.message(
      'last commit at ',
      name: 'repos_last_commit',
      desc: '',
      args: [],
    );
  }

  /// `all Issue：`
  String get repos_all_issue_count {
    return Intl.message(
      'all Issue：',
      name: 'repos_all_issue_count',
      desc: '',
      args: [],
    );
  }

  /// `open Issue：`
  String get repos_open_issue_count {
    return Intl.message(
      'open Issue：',
      name: 'repos_open_issue_count',
      desc: '',
      args: [],
    );
  }

  /// `close Issue：`
  String get repos_close_issue_count {
    return Intl.message(
      'close Issue：',
      name: 'repos_close_issue_count',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get repos_issue_search {
    return Intl.message(
      'Search',
      name: 'repos_issue_search',
      desc: '',
      args: [],
    );
  }

  /// `No Supprot Issue`
  String get repos_no_support_issue {
    return Intl.message(
      'No Supprot Issue',
      name: 'repos_no_support_issue',
      desc: '',
      args: [],
    );
  }

  /// `reply`
  String get issue_reply {
    return Intl.message(
      'reply',
      name: 'issue_reply',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get issue_edit {
    return Intl.message(
      'edit',
      name: 'issue_edit',
      desc: '',
      args: [],
    );
  }

  /// `open`
  String get issue_open {
    return Intl.message(
      'open',
      name: 'issue_open',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get issue_close {
    return Intl.message(
      'close',
      name: 'issue_close',
      desc: '',
      args: [],
    );
  }

  /// `lock`
  String get issue_lock {
    return Intl.message(
      'lock',
      name: 'issue_lock',
      desc: '',
      args: [],
    );
  }

  /// `unlock`
  String get issue_unlock {
    return Intl.message(
      'unlock',
      name: 'issue_unlock',
      desc: '',
      args: [],
    );
  }

  /// `reply Issue`
  String get issue_reply_issue {
    return Intl.message(
      'reply Issue',
      name: 'issue_reply_issue',
      desc: '',
      args: [],
    );
  }

  /// `commit Issue`
  String get issue_commit_issue {
    return Intl.message(
      'commit Issue',
      name: 'issue_commit_issue',
      desc: '',
      args: [],
    );
  }

  /// `edit issue`
  String get issue_edit_issue {
    return Intl.message(
      'edit issue',
      name: 'issue_edit_issue',
      desc: '',
      args: [],
    );
  }

  /// `edit reply`
  String get issue_edit_issue_commit {
    return Intl.message(
      'edit reply',
      name: 'issue_edit_issue_commit',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get issue_edit_issue_edit_commit {
    return Intl.message(
      'Edit',
      name: 'issue_edit_issue_edit_commit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get issue_edit_issue_delete_commit {
    return Intl.message(
      'Delete',
      name: 'issue_edit_issue_delete_commit',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get issue_edit_issue_copy_commit {
    return Intl.message(
      'Copy',
      name: 'issue_edit_issue_copy_commit',
      desc: '',
      args: [],
    );
  }

  /// `Could't not be empty`
  String get issue_edit_issue_content_not_be_null {
    return Intl.message(
      'Could\'t not be empty',
      name: 'issue_edit_issue_content_not_be_null',
      desc: '',
      args: [],
    );
  }

  /// `Could't not be empty`
  String get issue_edit_issue_title_not_be_null {
    return Intl.message(
      'Could\'t not be empty',
      name: 'issue_edit_issue_title_not_be_null',
      desc: '',
      args: [],
    );
  }

  /// `please input title`
  String get issue_edit_issue_title_tip {
    return Intl.message(
      'please input title',
      name: 'issue_edit_issue_title_tip',
      desc: '',
      args: [],
    );
  }

  /// `please input content`
  String get issue_edit_issue_content_tip {
    return Intl.message(
      'please input content',
      name: 'issue_edit_issue_content_tip',
      desc: '',
      args: [],
    );
  }

  /// `Notify`
  String get notify_title {
    return Intl.message(
      'Notify',
      name: 'notify_title',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get notify_tab_all {
    return Intl.message(
      'all',
      name: 'notify_tab_all',
      desc: '',
      args: [],
    );
  }

  /// `part`
  String get notify_tab_part {
    return Intl.message(
      'part',
      name: 'notify_tab_part',
      desc: '',
      args: [],
    );
  }

  /// `unread`
  String get notify_tab_unread {
    return Intl.message(
      'unread',
      name: 'notify_tab_unread',
      desc: '',
      args: [],
    );
  }

  /// `unread`
  String get notify_unread {
    return Intl.message(
      'unread',
      name: 'notify_unread',
      desc: '',
      args: [],
    );
  }

  /// `read`
  String get notify_readed {
    return Intl.message(
      'read',
      name: 'notify_readed',
      desc: '',
      args: [],
    );
  }

  /// `status`
  String get notify_status {
    return Intl.message(
      'status',
      name: 'notify_status',
      desc: '',
      args: [],
    );
  }

  /// `type`
  String get notify_type {
    return Intl.message(
      'type',
      name: 'notify_type',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_title {
    return Intl.message(
      'Search',
      name: 'search_title',
      desc: '',
      args: [],
    );
  }

  /// `Repos`
  String get search_tab_repos {
    return Intl.message(
      'Repos',
      name: 'search_tab_repos',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get search_tab_user {
    return Intl.message(
      'User',
      name: 'search_tab_user',
      desc: '',
      args: [],
    );
  }

  /// `Release`
  String get release_tab_release {
    return Intl.message(
      'Release',
      name: 'release_tab_release',
      desc: '',
      args: [],
    );
  }

  /// `Tag`
  String get release_tab_tag {
    return Intl.message(
      'Tag',
      name: 'release_tab_tag',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get user_profile_name {
    return Intl.message(
      'name',
      name: 'user_profile_name',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get user_profile_email {
    return Intl.message(
      'email',
      name: 'user_profile_email',
      desc: '',
      args: [],
    );
  }

  /// `link`
  String get user_profile_link {
    return Intl.message(
      'link',
      name: 'user_profile_link',
      desc: '',
      args: [],
    );
  }

  /// `company`
  String get user_profile_org {
    return Intl.message(
      'company',
      name: 'user_profile_org',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get user_profile_location {
    return Intl.message(
      'location',
      name: 'user_profile_location',
      desc: '',
      args: [],
    );
  }

  /// `info`
  String get user_profile_info {
    return Intl.message(
      'info',
      name: 'user_profile_info',
      desc: '',
      args: [],
    );
  }

  /// `type`
  String get search_type {
    return Intl.message(
      'type',
      name: 'search_type',
      desc: '',
      args: [],
    );
  }

  /// `sort`
  String get search_sort {
    return Intl.message(
      'sort',
      name: 'search_sort',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get search_language {
    return Intl.message(
      'language',
      name: 'search_language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
