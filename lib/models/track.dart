import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';


class Track extends INamed{
  String name;
  RatingGrades rating;
  List<TrackModifier> modifiers;

  Track(this.name, {rating, List<TrackModifier> modifiers}) {
    this.rating = rating ?? RatingGrades.notRated;
    this.modifiers = modifiers ?? List<TrackModifier>();
  }
}