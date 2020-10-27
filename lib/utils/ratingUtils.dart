import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/widgets/trackListRelated/rateTile.dart';

class RatingUtils {
  static Widget convertRatingToTextColour(RatingGrades rating) {
    String title;
    Color colour = getColorByRating(rating);
    switch (rating) {
      case RatingGrades.notRated:
        title = "Not rated";
        break;
      case RatingGrades.awful:
        title = "Awful";
        break;
      case RatingGrades.poor:
        title = "Poor";
        break;
      case RatingGrades.fine:
        title = "Fine";
        break;
      case RatingGrades.good:
        title = "Good";
        break;
      case RatingGrades.veryGood:
        title = "Very good";
        break;
      case RatingGrades.great:
        title = "Great";
        break;
      case RatingGrades.perfect:
        title = "Perfect";
        break;
      default:
        title = "Not set";
        break;
    }
    return Text(
      title,
      style:
          TextStyle(color: colour, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  static Color getColorByRating(RatingGrades rating) {
    Color colour;
    switch (rating) {
      case RatingGrades.notRated:
        colour = Colors.grey;
        break;
      case RatingGrades.awful:
        colour = Colors.red;
        break;
      case RatingGrades.poor:
        colour = Colors.orange;
        break;
      case RatingGrades.fine:
        colour = Colors.green[400];
        break;
      case RatingGrades.good:
        colour = Colors.green[600];
        break;
      case RatingGrades.veryGood:
        colour = Colors.green[800];
        break;
      case RatingGrades.great:
        colour = Colors.blue[600];
        break;
      case RatingGrades.perfect:
        colour = Colors.purple;
        break;
      default:
        colour = Colors.grey;
        break;
    }
    return colour;
  }

  static List<RateTile> getExistingTrackRateTiles() {
    List<RateTile> tiles =
        RatingGrades.values.map((e) => ExistingTrackRateTile(e)).toList();
    return tiles;
  }

  static List<RateTile> getNewTrackRateTiles() {
    List<RateTile> tiles =
        RatingGrades.values.map((e) => NewTrackRateTile(e)).toList();
    return tiles;
  }
}
