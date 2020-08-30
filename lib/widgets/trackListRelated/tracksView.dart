import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/historyBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/dialogs.dart';
import 'package:in_search_of_the_lost_chord/widgets/trackListRelated/history.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'package:shake/shake.dart';
import 'trackList.dart';

class TracksView extends StatefulWidget {
  final Release release;

  const TracksView(this.release);

  @override
  State<StatefulWidget> createState() {
    return _TracksViewState();
  }
}

class _TracksViewState extends State<TracksView> {
  ShakeDetector detector;
  @override
  void initState() {
    detector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        showDialog(
          context: context,
          builder: (context) => RemoveItemDialog(
              item: widget.release,
              removeFunction: (release) =>
                  Cores.releaseListCore.removeItem(release)),
        );
      },
      shakeSlopTimeMS: 5000,
    );
    detector.startListening();
    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

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
