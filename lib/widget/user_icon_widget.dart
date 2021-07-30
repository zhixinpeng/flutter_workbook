import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/style/theme.dart';

class UserIconWidget extends StatelessWidget {
  final String? image;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const UserIconWidget({
    Key? key,
    this.image,
    this.onPressed,
    this.width: 30.0,
    this.height: 30.0,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.only(top: 4, right: 5, left: 5),
      child: ClipOval(
        child: FadeInImage(
          placeholder: AssetImage(ThemeIcons.DEFAULT_USER_ICON),
          image: NetworkImage(image ?? ThemeIcons.DEFAULT_REMOTE_PIC),
          fit: BoxFit.fitWidth,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
