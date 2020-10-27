import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class Track extends INamed {
  RatingGrades rating;
  Map<TrackModifier, bool> modifiers;

  Track(name, {RatingGrades rating, List<TrackModifier> modifiers})
      : super(name: name) {
    this.rating = rating ?? RatingGrades.notRated;
    this.modifiers = modifiers ?? {TrackModifier.toReconsider: false};
  }

  Track.fromTrack(Track track) {
    name = track.name;
    rating = track.rating;
    modifiers = track.modifiers;
  }

  Track.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    int ratingIndex = json['rating'] as int;
    rating = ratingIndex < RatingGrades.values.length
        ? RatingGrades.values[ratingIndex]
        : RatingGrades.values[0];
    List<dynamic> modifiersDecoded = json['modifiers'];
    Map<TrackModifier, bool> convertedToMap = {
      TrackModifier.toReconsider: false
    };
    modifiersDecoded?.forEach((element) {
      convertedToMap[TrackModifier.values[element['modifier']]] =
          element['isEnabled'];
    });
    modifiers = convertedToMap;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> encodedModifiers = List<Map<String, dynamic>>();
    modifiers.forEach(
      (key, value) {
        encodedModifiers.add(
          TrackModifierWrapper(modifier: key, isEnabled: value).toJson(),
        );
      },
    );
    return {
      'name': name,
      'rating': rating.index,
      'modifiers': encodedModifiers
    };
  }

  void rate(RatingGrades newRating) {
    rating = newRating;
  }

  void changeName(String newName) {
    name = newName;
  }

  void toogleModifier(TrackModifier modifier) {
    modifiers[modifier] ^= true;
  }
}
