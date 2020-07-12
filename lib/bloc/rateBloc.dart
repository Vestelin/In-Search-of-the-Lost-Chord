import 'dart:async';

import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

import 'bloc.dart';

class RateBloc implements Bloc {
  final Track track;

  RateBloc(this.track);

  RatingGrades get rating => track.rating;
  set rating(value) => track.rating = value;

  final StreamController rateController = StreamController<RatingGrades>();

  Stream<RatingGrades> get rateStream => rateController.stream;

  RatingGrades getRating() {
    return rating;
  }

  void rateTrack(RatingGrades newRating) {
    rating = newRating;
    rateController.sink.add(newRating);
  }

  void dispose() => rateController.close();
}
