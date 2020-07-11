import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTile.dart';

class RateTrack extends StatefulWidget {
  final List<RateTile> rateTiles = RatingUtils.getRateTiles();
  @override
  State<StatefulWidget> createState() {
    return _RateTrackState();
  }
}

class _RateTrackState extends State<RateTrack> {
  @override
  Widget build(BuildContext context) {
    // return NotificationListener<OverscrollIndicatorNotification>(
    //   onNotification: (OverscrollIndicatorNotification overscroll) {
    //     overscroll.disallowGlow();
    //     return false;
    //   },
    // child:
    return Container(
      child: Center(
        child: SizedBox(
          height: 60,
          child: ListWheelScrollView(
            physics: BouncingScrollPhysics(),
            //squeeze: 1,
            //magnification: 5,
            //useMagnifier: true,
            // diameterRatio: 2,
            itemExtent: 60,
            children: widget.rateTiles,
            //perspective: 0.0015,
          ),
        ),
      ),
      //),
    );
  }
}

/* class RateTrack extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RateTrackState();
  }
}

class _RateTrackState extends State<RateTrack> {
  @override
  Widget build(BuildContext context) {
    return
  }
} */
