import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

import 'iNamed.dart';
import 'track.dart';
import 'utils/stringUtils.dart';

class Release extends INamed {
  static const int commaIndexPositionInRating = 1;
  List<Track> tracks;
  bool isConcept;
  Duration duration;

  void addTrack(Track track) {
    tracks.add(track);
  }

  Release(name, {int numberOfTracks: 0}) : super(name: name) {
    tracks = List<Track>();
    if (numberOfTracks > 0) {
      for (int i = 0; i < numberOfTracks; i++) {
        Track trackWithIndexAsName = Track(i.toString());
        tracks.add(trackWithIndexAsName);
      }
    }
  }

  Release.test() {
    name = "test";
    tracks = [
      Track("One of These Days", rating: RatingGrades.masterpiece),
      Track("a Pillow of Winds", rating: RatingGrades.excellent),
      Track("Fearless", rating: RatingGrades.fair),
      Track("San Tropez", rating: RatingGrades.moreThanGood),
      Track("Seamus", rating: RatingGrades.veryGood),
      Track("Echoes", rating: RatingGrades.masterpiece)
    ];
  }

  get ratingWithComma => StringUtils.insertCharAtIndex("rating", ',');
}
