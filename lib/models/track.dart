import 'dart:convert';

import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/modifiers/toReconsider.dart';

class Track extends INamed {
  String name;
  RatingGrades rating;
  Map<TrackModifier, bool> modifiers;

  Track(this.name, {RatingGrades rating, List<TrackModifier> modifiers}) {
    this.rating = rating ?? RatingGrades.notRated;
    this.modifiers = modifiers ?? {TrackModifier.toReconsider: false};
  }

  Track.fromTrack(Track track) {
    name = track.name;
    rating = track.rating;
    modifiers = track.modifiers;
  }

  Track.fromJson(Map<String, dynamic> json) {
    name = json[name];
    int ratingIndex = json['rating'] as int;
    rating = RatingGrades.values[ratingIndex];
    List<TrackModifierWrapper> modifiersDecoded = json[modifiers];
    Map<TrackModifier, bool> convertedToMap;
    modifiersDecoded.forEach((element) {
      convertedToMap[element.modifier] = element.isEnabled;
    });
    modifiers = convertedToMap;
  }

  Map<String, dynamic> toJson() {
    //Map<Map<String, dynamic>, Map<String, dynamic>> encodedModifiers = modifiers.map((key, value) => MapEntry(, value)));
    //Map<String, dynamic> try2 = {'modifierss': trying};
    //var e = JsonEncoder()..convert(trying);
    // var d = {1: "dada"};
    //return {'name': name, 'rating': rating.index, 'modifiers': try2};

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
