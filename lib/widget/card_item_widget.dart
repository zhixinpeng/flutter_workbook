import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/style/theme.dart';

class CardItemWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final Color? color;
  final RoundedRectangleBorder? shape;
  final double elevation;

  const CardItemWidget({
    Key? key,
    required this.child,
    this.margin: const EdgeInsets.all(10.0),
    this.color: ThemeColors.cardWhite,
    this.shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
    this.elevation: 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: shape,
      color: color,
      margin: margin,
      child: child,
    );
  }
}
