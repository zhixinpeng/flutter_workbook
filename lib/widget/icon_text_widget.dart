import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final String? iconText;

  final IconData iconData;

  final TextStyle textStyle;

  final Color iconColor;

  final double padding;

  final double iconSize;

  final VoidCallback? onPressed;

  final MainAxisAlignment mainAxisAlignment;

  final MainAxisSize mainAxisSize;

  final double textWidth;

  const IconTextWidget({
    Key? key,
    required this.iconData,
    required this.iconColor,
    required this.iconSize,
    required this.textStyle,
    this.padding: 0,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.textWidth: -1,
    this.iconText,
    this.onPressed,
  }) : super(key: key);

  Widget _showText(BuildContext context) {
    if (textWidth == -1) {
      return Container(
        child: Text(
          iconText ?? '',
          style: textStyle.merge(
            TextStyle(textBaseline: TextBaseline.alphabetic),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    } else {
      return Container(
        width: textWidth,
        child: Text(
          iconText ?? '',
          style: textStyle.merge(
            TextStyle(textBaseline: TextBaseline.alphabetic),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: iconSize,
            color: iconColor,
          ),
          Padding(padding: EdgeInsets.all(padding)),
          _showText(context)
        ],
      ),
    );
  }
}
