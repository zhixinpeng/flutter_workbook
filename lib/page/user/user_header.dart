import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/common/utils/common_utils.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/model/User.dart';
import 'package:flutter_workbook/model/UserOrg.dart';
import 'package:flutter_workbook/widget/card_item_widget.dart';
import 'package:flutter_workbook/widget/icon_text_widget.dart';
import 'package:flutter_workbook/widget/user_icon_widget.dart';

class UserHeader extends StatelessWidget {
  final User userInfo;
  final String starredCount;
  final Color? notifyColor;
  final Color themeColor;
  final VoidCallback? refreshCallback;
  final List<UserOrg>? orgList;

  const UserHeader({
    Key? key,
    required this.userInfo,
    required this.starredCount,
    required this.themeColor,
    this.notifyColor,
    this.refreshCallback,
    this.orgList,
  }) : super(key: key);

  _renderImg(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: ThemeIcons.DEFAULT_USER_ICON,
          image: userInfo.avatar_url ?? ThemeIcons.DEFAULT_REMOTE_PIC,
          fit: BoxFit.fitWidth,
          width: 80,
          height: 80,
        ),
      ),
    );
  }

  _getNotifyIcon(BuildContext context, Color? color) {
    if (color == null) return Container();
    return RawMaterialButton(
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.only(top: 0, right: 5, left: 5),
      constraints: BoxConstraints(minHeight: 0, minWidth: 0),
      child: ClipOval(
        child: Icon(
          ThemeIcons.USER_NOTIFY,
          color: color,
          size: 18,
        ),
      ),
    );
  }

  _renderUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              userInfo.login ?? '',
              style: ThemeTextStyle.largeTextWhiteBold,
            ),
            _getNotifyIcon(context, notifyColor),
          ],
        ),
        Text(
          userInfo.name == null ? '' : userInfo.name!,
          style: ThemeTextStyle.smallSubLightText,
        ),
        IconTextWidget(
          padding: 3,
          iconData: ThemeIcons.USER_ITEM_COMPANY,
          iconColor: ThemeColors.subLightTextColor,
          iconText: userInfo.company ?? S.current.nothing_now,
          textStyle: ThemeTextStyle.smallSubLightText,
          iconSize: 10,
        ),
        IconTextWidget(
          iconData: ThemeIcons.USER_ITEM_LOCATION,
          iconColor: ThemeColors.subLightTextColor,
          iconSize: 10,
          textStyle: ThemeTextStyle.smallSubLightText,
          iconText: userInfo.location ?? S.current.nothing_now,
          padding: 3,
        ),
      ],
    );
  }

  Widget _renderBlog(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 2),
      alignment: Alignment.topLeft,
      child: RawMaterialButton(
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.all(0),
        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
        child: IconTextWidget(
          iconData: ThemeIcons.USER_ITEM_LINK,
          iconColor: ThemeColors.subLightTextColor,
          iconSize: 10,
          textStyle: userInfo.blog != null ? ThemeTextStyle.smallSubLightText : ThemeTextStyle.smallActionLightText,
          textWidth: MediaQuery.of(context).size.width - 50,
          padding: 3,
          iconText: userInfo.blog ?? S.current.nothing_now,
        ),
      ),
    );
  }

  Widget _renderOrgs(BuildContext context, List<UserOrg>? orgList) {
    print(orgList);
    if (orgList == null || orgList.length == 0) return Container();

    List<Widget> list = [];
    int length = orgList.length > 3 ? 3 : orgList.length;

    list.add(
      Text(
        S.current.user_orgs_title + ':',
        style: ThemeTextStyle.smallSubLightText,
      ),
    );

    Widget renderOrgItem(UserOrg org) {
      return UserIconWidget(
        padding: EdgeInsets.only(right: 5, left: 5),
        width: 30,
        height: 30,
        image: org.avatarUrl ?? ThemeIcons.DEFAULT_REMOTE_PIC,
        onPressed: () {},
      );
    }

    for (int i = 0; i < length; i++) {
      list.add(renderOrgItem(orgList[i]));
    }

    if (orgList.length > 3) {
      list.add(
        RawMaterialButton(
          onPressed: () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.only(right: 5, left: 5),
          constraints: BoxConstraints(minWidth: 0, minHeight: 0),
          child: Icon(
            Icons.more_horiz,
            color: ThemeColors.white,
            size: 18,
          ),
        ),
      );
    }

    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return CardItemWidget(
      color: themeColor,
      elevation: 0,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _renderImg(context),
                Padding(padding: EdgeInsets.all(10)),
                Expanded(child: _renderUserInfo(context)),
              ],
            ),
            _renderBlog(context),
            _renderOrgs(context, orgList),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                userInfo.bio == null ? '' : userInfo.bio!,
                style: ThemeTextStyle.smallSubLightText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6, bottom: 2),
              alignment: Alignment.topLeft,
              child: Text(
                S.current.user_create_at + CommonUtils.getDateStr(userInfo.created_at),
                style: ThemeTextStyle.smallSubLightText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),
          ],
        ),
      ),
    );
  }
}

class UserHeaderBottom extends StatelessWidget {
  final User userInfo;

  final String beStarredCount;

  final Radius radius;

  final List? honorList;

  const UserHeaderBottom({
    Key? key,
    required this.userInfo,
    required this.beStarredCount,
    required this.radius,
    this.honorList,
  }) : super(key: key);

  Widget _getBottomItem({String? title, dynamic count, required VoidCallback onPressed}) {
    String data = count == null ? '' : count.toString();
    TextStyle titleStyle =
        (title != null && title.toString().length > 6) ? ThemeTextStyle.minText : ThemeTextStyle.smallSubLightText;
    TextStyle valueStyle =
        (count != null && count.toString().length > 6) ? ThemeTextStyle.minText : ThemeTextStyle.smallSubLightText;

    return Expanded(
      child: Center(
        child: RawMaterialButton(
          onPressed: onPressed,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.only(top: 5),
          constraints: BoxConstraints(minHeight: 0, minWidth: 0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: title, style: titleStyle),
                TextSpan(text: '\n', style: valueStyle),
                TextSpan(text: data, style: valueStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(userInfo.starred);
    return CardItemWidget(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getBottomItem(
              title: S.current.user_tab_repos,
              count: userInfo.public_repos,
              onPressed: () => {},
            ),
            Container(
              width: .3,
              height: 40,
              alignment: Alignment.center,
              color: ThemeColors.subLightTextColor,
            ),
            _getBottomItem(
              title: S.current.user_tab_fans,
              count: userInfo.followers,
              onPressed: () {},
            ),
            Container(
              width: .3,
              height: 40,
              alignment: Alignment.center,
              color: ThemeColors.subLightTextColor,
            ),
            _getBottomItem(
              title: S.current.user_tab_focus,
              count: userInfo.following,
              onPressed: () {},
            ),
            Container(
              width: .3,
              height: 40,
              alignment: Alignment.center,
              color: ThemeColors.subLightTextColor,
            ),
            _getBottomItem(
              title: S.current.user_tab_star,
              count: userInfo.starred,
              onPressed: () {},
            ),
            Container(
              width: .3,
              height: 40,
              alignment: Alignment.center,
              color: ThemeColors.subLightTextColor,
            ),
            _getBottomItem(
              title: S.current.user_tab_honor,
              count: beStarredCount,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class UserHeaderChart extends StatelessWidget {
  final User userInfo;

  const UserHeaderChart(this.userInfo, {Key? key}) : super(key: key);

  Widget _renderChart(BuildContext context) {
    double height = 140;
    double width = 3 * MediaQuery.of(context).size.width / 2;

    if (userInfo.login != null && userInfo.type == 'Organization') return Container();

    if (userInfo.login == null) {
      return Container(
        height: height,
        child: Center(
          child: SpinKitRipple(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return Card(
      color: ThemeColors.white,
      margin: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SvgPicture.network(
            CommonUtils.getUserChartAddress(userInfo.login!),
            width: width,
            height: height - 10,
            allowDrawingOutsideViewBox: true,
            placeholderBuilder: (context) {
              return Container(
                height: height,
                width: width,
                child: Center(
                  child: SpinKitRipple(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15, left: 12),
            alignment: Alignment.topLeft,
            child: Text(
              userInfo.type == 'Organization' ? S.current.user_dynamic_group : S.current.user_dynamic_title,
              style: ThemeTextStyle.normalTextBold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _renderChart(context),
        ],
      ),
    );
  }
}
