import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

import 'track.dart';
import 'utils/stringUtils.dart';

class Release {
  static const int commaIndexPositionInRating = 1;
  String name;
  List<Track> tracks;
  bool isConcept;
  Duration duration;

  Release(this.name, {int numberOfTracks:0}) {
    tracks = List<Track>()
    ..length = numberOfTracks;
  }

  Release.test() {
    name = "test";
    tracks = [Track("Track1", RatingGrades.masterpiece), Track("Track2", RatingGrades.notRated)];
  }

  get ratingWithComma => StringUtils.insertCharAtIndex("rating", ',');
}