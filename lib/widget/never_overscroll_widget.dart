import 'package:flutter/material.dart';

class NeverOverScrollWidget extends StatelessWidget {
  final bool needOverload;
  final Widget? child;

  const NeverOverScrollWidget({
    Key? key,
    this.child,
    this.needOverload: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NeverOverScrollBehavior(needOverload: needOverload),
      child: child!,
    );
  }
}

class NeverOverScrollBehavior extends ScrollBehavior {
  final bool needOverload;

  NeverOverScrollBehavior({this.needOverload: true});

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return super.buildOverscrollIndicator(context, child, details);
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        if (needOverload) {
          return const BouncingScrollPhysics();
        }
        return const ClampingScrollPhysics();
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      default:
        return const ClampingScrollPhysics();
    }
  }
}
