import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/historyBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/trackListRelated/history.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'trackList.dart';

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
        body: BlocProvider<TrackListBloc>(
          bloc: TrackListBloc(widget.release),
          child: BlocProvider<HistoryBloc>(
            bloc: HistoryBloc(widget.release),
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [TrackList(widget.release.tracks), History()]),
          ),
        ),
        //   extendBody: true,
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
