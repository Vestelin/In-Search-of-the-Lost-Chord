import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class Track extends INamed {
  String name;
  RatingGrades rating;
  Map<TrackModifier, bool> modifiers;

  Track(this.name, {RatingGrades rating, Map<TrackModifier, bool> modifiers}) {
    this.rating = rating ?? RatingGrades.notRated;
    this.modifiers = modifiers ?? {TrackModifier.toReconsider: false};
  }
}
