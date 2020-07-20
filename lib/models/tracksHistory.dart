import 'package:in_search_of_the_lost_chord/models/track.dart';

class TracksHistory {
  DateTime dateOfSaving;
  List<Track> tracks;

  TracksHistory({this.tracks}) {
    var now = DateTime.now();
    dateOfSaving = DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  TracksHistory.fromJson(Map<String, dynamic> json) {
    dateOfSaving = json['dateOfSaving'];
    var deserializedTracks = json['tracks'] as List;
    tracks = deserializedTracks.map((e) => Track.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> encodedTracks =
        tracks.map((e) => e.toJson()).toList();
    return {'dateOfSaving': dateOfSaving.toString(), 'tracks': encodedTracks};
  }
}
