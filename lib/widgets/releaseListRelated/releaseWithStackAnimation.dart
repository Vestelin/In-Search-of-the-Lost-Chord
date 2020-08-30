import 'package:flutter/material.dart';

import '../mainPageRelated/stackAnimationProvider.dart';
import 'releases.dart';

class ReleasesWithStackAnimation extends StatefulWidget {
  @override
  _ReleasesWithStackAnimationState createState() =>
      _ReleasesWithStackAnimationState();
}

class _ReleasesWithStackAnimationState
    extends State<ReleasesWithStackAnimation> {
  AnimationController controller;
  @override
  void initState() {
    controller = StackAnimationProvider.ofState(context).controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: StackAnimationProvider.ofState(context).controller,
      child: const Releases(),
      builder: (BuildContext context, Widget child) {
        double scale = 1 - (0.5 * controller.value);
        double translateHeight =
            (MediaQuery.of(context).size.height * 0.100 * controller.value);
        double translateWidth =
            (MediaQuery.of(context).size.width * 0.625 * controller.value);
        return Transform(
            transform: Matrix4.identity()
              ..translate(translateWidth, translateHeight)
              ..scale(scale),
            child: child);
      },
    );
  }
}
