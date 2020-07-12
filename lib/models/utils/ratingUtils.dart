import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/rateBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTile.dart';

class RatingUtils {
  static Widget convertRatingToTextColour(RatingGrades rating) {
    String title;
    Color colour = getColorByRating(rating);
    switch (rating) {
      case RatingGrades.notRated:
        title = "Not rated";
        break;
      case RatingGrades.poor:
        title = "Poor";
        break;
      case RatingGrades.fair:
        title = "Fair";
        break;
      case RatingGrades.quiteGood:
        title = "Quite good";
        break;
      case RatingGrades.good:
        title = "Good";
        break;
      case RatingGrades.moreThanGood:
        title = "More than good";
        break;
      case RatingGrades.veryGood:
        title = "Very good";
        break;
      case RatingGrades.excellent:
        title = "Excellent";
        break;
      case RatingGrades.masterpiece:
        title = "Masterpiece";
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
      case RatingGrades.poor:
        colour = Colors.red;
        break;
      case RatingGrades.fair:
        colour = Colors.orange;
        break;
      case RatingGrades.quiteGood:
        colour = Colors.yellow;
        break;
      case RatingGrades.good:
        colour = Colors.green[400];
        break;
      case RatingGrades.moreThanGood:
        colour = Colors.green[600];
        break;
      case RatingGrades.veryGood:
        colour = Colors.green[800];
        break;
      case RatingGrades.excellent:
        colour = Colors.blue;
        break;
      case RatingGrades.masterpiece:
        colour = Colors.purple;
        break;
    }
    return colour;
  }

  static List<RateTile> getRateTiles() {
    List<RateTile> tiles = RatingGrades.values.map((e) => RateTile(e)).toList();
    return tiles;
  }
}
