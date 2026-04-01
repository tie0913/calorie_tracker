import 'package:flutter/material.dart';

class NoStretchScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // 关键：直接返回 child → 禁用拉伸/光晕
  }
}