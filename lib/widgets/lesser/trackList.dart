import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/trackTile.dart';

class TrackList extends StatefulWidget {
  final List<Track> tracks;
  TrackList(this.tracks);
  @override
  _TrackListState createState() => _TrackListState(tracks);
}

class _TrackListState extends State<TrackList> {
  List<Track> tracks;
  RatingAnimatedListCore<Track> core;
  _TrackListState(this.tracks) {
    core = RatingAnimatedListCore(
        (item) => BlocProvider(bloc: TrackBloc(item), child: TrackTile(item)),
        GlobalKey<AnimatedListState>(),
        tracks,
        false);
    Cores.currentTrackCore = core;
  }
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TrackListBloc>(context);
    return StreamBuilder<Object>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return AnimatedList(
            itemBuilder: (context, index, animation) =>
                core.buildItem(index, animation),
            key: core.listKey,
            initialItemCount: tracks.length,
          );
        });
  }
}
