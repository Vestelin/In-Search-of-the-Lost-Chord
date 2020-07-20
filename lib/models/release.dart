import 'package:in_search_of_the_lost_chord/models/tracksHistory.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

import 'iNamed.dart';
import 'track.dart';

class Release extends INamed {
  List<Track> tracks = List<Track>();
  List<TracksHistory> historyOfRatings;

  void addTrack(Track track) {
    tracks.add(track);
  }

  void resetTracksRating() {
    tracks.forEach((element) => element.rate(RatingGrades.notRated));
  }

  void addCurrentTracksToHistory() {
    var historyTracks = tracks.map((e) => Track.fromTrack(e)).toList();
    historyOfRatings.add(TracksHistory(tracks: historyTracks));
  }

  void historyTracks() {
    addCurrentTracksToHistory();
    resetTracksRating();
  }

  Release(name, {int numberOfTracks: 0}) : super(name: name) {
    historyOfRatings = List<TracksHistory>();
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
    historyOfRatings = List<TracksHistory>();
    tracks = [
      Track("One of These Days", rating: RatingGrades.masterpiece),
      Track("a Pillow of Winds", rating: RatingGrades.excellent),
      Track("Fearless", rating: RatingGrades.fair),
      Track("San Tropez", rating: RatingGrades.moreThanGood),
      Track("Seamus", rating: RatingGrades.veryGood),
      Track("Echoes", rating: RatingGrades.masterpiece)
    ];
  }
}
