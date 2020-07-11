import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';

class RateTile extends StatelessWidget {
  final RatingGrades grade;
  RateTile(this.grade);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
      ),
      //color: Colors.grey,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Center(child: RatingUtils.convertRatingToTextColour(grade)),
      ),
    );
  }
}
