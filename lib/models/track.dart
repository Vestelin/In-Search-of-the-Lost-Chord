import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';


class Track {
  String name;
  RatingGrades rating;
  List<TrackModifier> modifiers;

  Track(this.name, this.rating, {List<TrackModifier> modifiess}) {
    this.modifiers = modifiess == null ? List<TrackModifier>() : modifiess;
  }
}