import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'lesser/trackList.dart';

class TracksView extends StatefulWidget {
  final Release release;

  TracksView(this.release);

  @override
  State<StatefulWidget> createState() {
    return _TracksViewState();
  }
}

class _TracksViewState extends State<TracksView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.release.name),
        ),
        body: BlocProvider<TrackListBloc>(
          bloc: TrackListBloc(widget.release),
          child: TabBarView(
              children: [TrackList(widget.release.tracks), Placeholder()]),
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            const TabBarContainer(const Icon(Icons.queue_music), "Tracks"),
            const TabBarContainer(const Icon(Icons.history), "History")
          ],
        ),
      ),
    );
  }
}
