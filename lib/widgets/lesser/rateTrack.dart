import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTile.dart';

class RateTrack extends StatefulWidget {
  final List<RateTile> rateTiles; // = RatingUtils.getExistingTrackRateTiles();
  RateTrack(this.rateTiles);
  @override
  State<StatefulWidget> createState() {
    return _RateTrackState();
  }
}

class _RateTrackState extends State<RateTrack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SizedBox(
          height: 60,
          child: ListView(
            physics: BouncingScrollPhysics(),
            itemExtent: 60,
            children: widget.rateTiles,
          ),
        ),
      ),
    );
  }
}
