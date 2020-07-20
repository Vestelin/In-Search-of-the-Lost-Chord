import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/models/tracksHistory.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/dialogs.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/trackTile.dart';

class HistoryTrackList extends StatelessWidget {
  final TracksHistory history;
  HistoryTrackList(this.history);
  @override
  Widget build(BuildContext context) {
    List<Track> tracks = history.tracks;
    return Scaffold(
      appBar: AppBar(
        title: Text(history.dateOfSaving.toString()),
      ),
      body: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) => HistoryTrackTile(tracks[index]),
      ),
    );
  }
}

class TrackList extends StatefulWidget {
  final List<Track> tracks;
  TrackList(this.tracks);
  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TrackListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bloc.releaseName),
        actions: <Widget>[
          Container(
            width: 60,
            child: FlatButton(
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => BlocProvider<AddingTrackBloc>(
                          child: AddTrackDialog(),
                          bloc: AddingTrackBloc(trackListBloc: bloc)),
                    ),
                child: Icon(Icons.add)),
          )
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
                  bloc: TrackBloc(tracksData[index]),
                  child: TrackTile(tracksData[index],
                      key: ValueKey(tracksData[index]))));
        },
      ),
    );
  }
}
