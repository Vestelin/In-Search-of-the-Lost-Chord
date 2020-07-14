import 'dart:async';

import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

import 'bloc.dart';

class TrackBloc implements Bloc {
  final Track track;

  TrackBloc(this.track, this.refreshFunction);

  final Function(Track) refreshFunction;

  RatingGrades get rating => track.rating;
  set rating(value) => track.rating = value;

  final StreamController rateController = StreamController<Track>();

  Stream<Track> get trackStream => rateController.stream;

  RatingGrades getRating() {
    return rating;
  }

  void rateTrack(RatingGrades newRating) {
    rating = newRating;
    rateController.sink.add(track);
    refreshFunction(track);
  }

  void dispose() => rateController.close();
}