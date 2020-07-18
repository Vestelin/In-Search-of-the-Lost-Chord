import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/dialogs.dart';
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
    /* core = RatingAnimatedListCore(
        (item) => BlocProvider(bloc: TrackBloc(item), child: TrackTile(item)),
        GlobalKey<AnimatedListState>(),
        tracks,
        false); */
    Cores.currentTrackCore = core;
  }
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TrackListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider<AddingTrackBloc>(
                        child: AddTrackDialog(),
                        bloc: AddingTrackBloc(trackListBloc: bloc)),
                  ),
              child: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<Track>>(
        stream: bloc.stream,
        initialData: bloc.tracks,
        builder: (context, snapshot) {
          List<Track> tracksData = snapshot.data;
          if (tracksData == null) return Container();
          return ListView.builder(
              itemCount: tracksData.length,
              itemBuilder: (context, index) => BlocProvider(
                  bloc: TrackBloc(tracksData[index], bloc.loadTracks),
                  child: TrackTile(tracksData[index], key: UniqueKey())));
        },
      ),
    );
    /* return AnimatedList(
            itemBuilder: (context, index, animation) =>
                core.buildItem(index, animation),
            key: core.listKey,
            initialItemCount: tracks.length,
          );
        } );*/
  }
}
