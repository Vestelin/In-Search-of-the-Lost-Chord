import 'package:in_search_of_the_lost_chord/models/track.dart';

class TracksHistory {
  DateTime dateOfSaving;
  final List<Track> tracks;

  TracksHistory({this.tracks}) {
    var now = DateTime.now();
    dateOfSaving = DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }
}
