import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final TickerProvider vSync;
  final FloatingHeaderSnapConfiguration snapConfig;
  final bool? changeSize;
  final Widget? child;
  final SliverBuilder? builder;

  SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.snapConfig,
    required this.vSync,
    this.child,
    this.builder,
    this.changeSize: false,
  });

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  TickerProvider? get vsync => vSync;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => snapConfig;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (builder != null) {
      return builder!(context, shrinkOffset, overlapsContent);
    }
    return child!;
  }
}

typedef Widget SliverBuilder(BuildContext context, double shrinkOffset, bool overlapsContent);
