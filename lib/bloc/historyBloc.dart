import 'dart:async';

import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/models/tracksHistory.dart';

import 'bloc.dart';

class HistoryBloc extends Bloc {
  final Release release;
  TracksHistory currentHistory;
  List<TracksHistory> get historyList => release.historyOfRatings;

  HistoryBloc(this.release);

  String get releaseName => release.name;

  StreamController<List<TracksHistory>> _controller =
      StreamController<List<TracksHistory>>.broadcast();

  Stream<List<TracksHistory>> get stream => _controller.stream;

  void addHistory() {
    release.historyTracks();
    _controller.sink.add(historyList);
    Database.saveReleases();
  }

  @override
  void dispose() {
    _controller.close();
  }
}
