import 'package:flutter/material.dart';

class ScrollControllerProvider extends InheritedWidget {
  final ScrollController controller;
  final int index;
  ScrollControllerProvider({Widget child, this.index: -1})
      : controller = ScrollController(),
        super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static ScrollControllerProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
  }
}
