import 'package:flutter/material.dart';

class RatingListProvider extends InheritedWidget {

  static RatingListProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RatingListProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) { 
    return null;
  }

}