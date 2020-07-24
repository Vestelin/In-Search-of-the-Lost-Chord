import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTile.dart';
import 'package:in_search_of_the_lost_chord/widgets/scrollControllerProvider.dart';

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
  RateTrack(this.rateTiles);
  @override
  Widget build(BuildContext context) {
    final ScrollControllerProvider controllerProvider =
        ScrollControllerProvider.of(context);
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
            controller: controllerProvider.controller,
          ),
        ),
      ),
    );
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
