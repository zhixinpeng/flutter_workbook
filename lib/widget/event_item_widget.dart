import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/style/theme.dart';
import 'package:flutter_workbook/common/utils/common_utils.dart';
import 'package:flutter_workbook/common/utils/event_utils.dart';
import 'package:flutter_workbook/generated/l10n.dart';
import 'package:flutter_workbook/model/Notification.dart' as Model;
import 'package:flutter_workbook/model/RepoCommit.dart';
import 'package:flutter_workbook/model/Event.dart';
import 'package:flutter_workbook/widget/card_item_widget.dart';
import 'package:flutter_workbook/widget/user_icon_widget.dart';

class EventItemWidget extends StatelessWidget {
  final EventViewModel eventViewModel;
  final VoidCallback? onPressed;
  final bool needImage;

  const EventItemWidget(this.eventViewModel, {Key? key, this.onPressed, this.needImage: true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget userImage = needImage
        ? UserIconWidget(
            padding: EdgeInsets.only(top: 0, right: 5, left: 0),
            width: 30,
            height: 30,
            image: eventViewModel.actionUserPic,
          )
        : Container();

    Widget desc = (eventViewModel.actionDes == null || eventViewModel.actionDes!.length == 0)
        ? Container()
        : Container(
            child: Text(
              eventViewModel.actionDes!,
              style: ThemeTextStyle.smallSubText,
              maxLines: 3,
            ),
            margin: EdgeInsets.only(top: 6, bottom: 2),
            alignment: Alignment.topLeft,
          );

    return Container(
      child: CardItemWidget(
        child: TextButton(
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    userImage,
                    Expanded(
                      child: Text(
                        eventViewModel.actionUser!,
                        style: ThemeTextStyle.smallTextBold,
                      ),
                    ),
                    Text(
                      eventViewModel.actionTime,
                      style: ThemeTextStyle.smallSubText,
                    )
                  ],
                ),
                Container(
                  child: Text(
                    eventViewModel.actionTarget!,
                    style: ThemeTextStyle.smallTextBold,
                  ),
                  margin: EdgeInsets.only(top: 6, bottom: 2),
                  alignment: Alignment.topLeft,
                ),
                desc,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventViewModel {
  String? actionUser;
  String? actionUserPic;
  String? actionDes;
  String? actionTarget;
  late String actionTime;

  EventViewModel.fromEventMap(Event event) {
    actionTime = CommonUtils.getNewsTimeStr(event.createdAt!);
    actionUser = event.actor?.login;
    actionUserPic = event.actor!.avatar_url;
    var other = EventUtils.getActionAndDes(event);
    actionDes = other['des'];
    actionTarget = other['actionStr'];
  }

  EventViewModel.fromCommitMap(RepoCommit eventMap) {
    actionTime = CommonUtils.getNewsTimeStr(eventMap.commit!.committer!.date!);
    actionUser = eventMap.commit!.committer!.name;
    actionDes = "sha:" + eventMap.sha!;
    actionTarget = eventMap.commit!.message;
  }

  EventViewModel.fromNotify(BuildContext context, Model.Notification eventMap) {
    actionTime = CommonUtils.getNewsTimeStr(eventMap.updateAt!);
    actionUser = eventMap.repository!.fullName;
    String? type = eventMap.subject!.type;
    String status = eventMap.unread! ? S.current.notify_unread : S.current.notify_readed;
    actionDes = eventMap.reason! + "${S.current.notify_type}：$type，${S.current.notify_status}：$status";
    actionTarget = eventMap.subject!.title;
  }
}
