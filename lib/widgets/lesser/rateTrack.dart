import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTile.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/scrollControllerProvider.dart';

/* class RateTrack extends StatefulWidget {
  final List<RateTile> rateTiles;
  RateTrack(
    this.rateTiles,
  );
  @override
  State<StatefulWidget> createState() {
    return _RateTrackState();
  }
}
*/
class RateTrack extends StatelessWidget {
  final List<RateTile> rateTiles;
  final bool scrollToCurrentRating;
  RateTrack(this.rateTiles, this.scrollToCurrentRating);
  @override
  Widget build(BuildContext context) {
    ScrollControllerProvider controllerProvider;
    if (scrollToCurrentRating) {
      controllerProvider = ScrollControllerProvider.of(context);
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => scrollToProperRateTile(controllerProvider));
    }
    return Container(
      child: SizedBox(
        height: 180,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView(
            itemExtent: 60,
            children: rateTiles,
            controller: controllerProvider?.controller ?? ScrollController(),
          ),
        ),
      ),
    );
  }
}

Future<void> scrollToProperRateTile(ScrollControllerProvider provider) async {
  const int extentOfItemInList = 60;
  if (provider.index != -1) {
    ScrollController controller = provider.controller;
    controller.jumpTo(((provider.index > 0
                ? provider.index == RatingGrades.values.length - 1
                    ? provider.index - 2
                    : provider.index - 1
                : provider.index) *
            extentOfItemInList)
        .toDouble());
  }
}

/*
class _RateTrackState extends State<RateTrack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 180,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: ListView(
            itemExtent: 60,
            children: widget.rateTiles,
          ),
        ),
      ),
    );
  }
}
 */
