import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/releaseListRelated/releaseWithStackAnimation.dart';
import 'package:in_search_of_the_lost_chord/widgets/statisticsRelated/statistics.dart';

import 'stackAnimationProvider.dart';

class StackOfStatisticsAndReleaseList extends StatefulWidget {
  const StackOfStatisticsAndReleaseList({
    Key key,
  }) : super(key: key);

  @override
  _StackOfStatisticsAndReleaseListState createState() =>
      _StackOfStatisticsAndReleaseListState();
}

class _StackOfStatisticsAndReleaseListState
    extends State<StackOfStatisticsAndReleaseList> {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = StackAnimationProvider.ofState(context).controller;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isDismissed) {
          StackAnimationProvider.ofState(context).ignoreGesture.value = false;
          controller.reverse();
        }
      },
      child: Stack(
        children: [
          Statistics(),
          SafeArea(
            child: ValueListenableBuilder(
              valueListenable:
                  StackAnimationProvider.ofState(context).ignoreGesture,
              child: ReleasesWithStackAnimation(),
              builder: (BuildContext context, bool ignore, Widget child) =>
                  IgnorePointer(ignoring: ignore, child: child),
            ),
          ),
        ],
      ),
    );
  }
}
