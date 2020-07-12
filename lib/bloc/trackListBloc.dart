import 'dart:async';

import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

import 'bloc.dart';

class TrackListBloc implements Bloc {
  final Release _release;
  List<Track> _tracks;

  TrackListBloc(this._release) {
    _tracks = _release.tracks;
  }

  StreamController<List<Track>> controller = StreamController<List<Track>>();

  Stream<List<Track>> get stream => controller.stream;

  void addTrack(track) {
    _release.addTrack(track);
  }

  void loadTracks() {
    controller.sink.add(_tracks);
  }

  @override
  void dispose() {
    controller.close();
  }
}
