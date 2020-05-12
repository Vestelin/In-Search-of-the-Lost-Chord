import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/trackTile.dart';

class TrackList extends StatelessWidget {
  final List<Track> tracks;
  TrackList(this.tracks) {
    core = RatingAnimatedListCore((item) => TrackTile(item), GlobalKey<AnimatedListState>(), tracks, false);
  }
  RatingAnimatedListCore<Track> core;
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      itemBuilder: (context, index, animation) =>
          core.buildItem(index, animation),
      key: core.listKey,
      initialItemCount: tracks.length,
    );
  }
}
