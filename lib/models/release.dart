import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

import 'iNamed.dart';
import 'track.dart';
import 'utils/stringUtils.dart';

class Release extends INamed {
  List<Track> tracks = List<Track>();
  List<List<Track>> historyOfRatings = List<List<Track>>();

  void addTrack(Track track) {
    tracks.add(track);
  }

  void resetTracksRating() {
    tracks.forEach((element) => element.rate(RatingGrades.notRated));
  }

  void addCurrentTracksToHistory() {
    historyOfRatings.add(List<Track>.from(tracks));
  }

  void historyTracks() {
    addCurrentTracksToHistory();
    resetTracksRating();
  }

  Release(name, {int numberOfTracks: 0}) : super(name: name) {
    tracks = List<Track>();
    if (numberOfTracks > 0) {
      for (int i = 1; i <= numberOfTracks; i++) {
        Track trackWithIndexAsName = Track("Track " + (i).toString());
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
