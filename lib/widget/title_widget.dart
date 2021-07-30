import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final Widget? rightWidget;
  final bool needRightLocalIcon;
  final ValueChanged? onRightIconPressed;
  final GlobalKey rightKey = GlobalKey();

  TitleWidget(
    this.title, {
    Key? key,
    this.iconData,
    this.rightWidget,
    this.needRightLocalIcon: false,
    this.onRightIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _widget = rightWidget;

    if (rightWidget == null) {
      _widget = needRightLocalIcon
          ? IconButton(
              icon: Icon(
                iconData,
                key: rightKey,
                size: 19,
              ),
              onPressed: () {
                RenderBox renderBox = rightKey.currentContext?.findRenderObject() as RenderBox;
                var position = renderBox.localToGlobal(Offset.zero);
                var size = renderBox.size;
                var centerPosition = Offset(
                  position.dx + size.width / 2,
                  position.dy + size.height / 2,
                );
                onRightIconPressed?.call(centerPosition);
              },
            )
          : Container();
    }

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _widget!,
        ],
      ),
    );
  }
}
