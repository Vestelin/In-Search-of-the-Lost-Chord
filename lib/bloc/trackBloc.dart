import 'dart:async';

import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

import 'bloc.dart';

class TrackBloc implements Bloc {
  final Track track;

  TrackBloc(this.track);

  RatingGrades get rating => track.rating;
  Map<TrackModifier, bool> get modifiers => track.modifiers;

  final StreamController rateController = StreamController<Track>.broadcast();

  Stream<Track> get trackStream => rateController.stream;

  void rateTrack(RatingGrades newRating) {
    track.rate(newRating);
    rateController.sink.add(track);
    Database.saveReleases();
  }

  void changeName(String newName) {
    track.changeName(newName);
    Database.saveReleases();
    rateController.sink.add(track);
  }

  void switchModifier(TrackModifier modifier) {
    track.toogleModifier(modifier);
    Database.saveReleases();
    rateController.sink.add(track);
  }

  void dispose() => rateController.close();
}
