import 'dart:async';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

import 'bloc.dart';

class TrackListBloc implements Bloc {
  final Release _release;
  Track lastDeletedTrack;

  TrackListBloc(this._release);

  String get releaseName => _release.name;

  List<Track> get tracks => _release.tracks;

  StreamController<List<Track>> controller =
      StreamController<List<Track>>.broadcast();

  Stream<List<Track>> get stream => controller.stream;

  void deleteTrack(Track track) {
    lastDeletedTrack = track;
    _release.deleteTrack(track);
    controller.sink.add(tracks);
    Database.saveReleases();
  }

  void addTrack(Track track, {int index}) {
    index == null
        ? _release.addTrack(track)
        : _release.addTrackAtIndex(track, index);
    controller.sink.add(tracks);
    Database.saveReleases();
  }

  void loadTracks() {
    controller.sink.add(tracks);
  }

  @override
  void dispose() {
    controller.close();
  }
}
