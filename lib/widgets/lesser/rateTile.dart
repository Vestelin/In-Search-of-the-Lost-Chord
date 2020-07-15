import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrackDialog.dart';

class RateTile extends StatelessWidget {
  final RatingGrades grade;
  RateTile(this.grade);

  @override
  Widget build(BuildContext context) {
    final bloc = TrackBlocProvider.of(context).bloc;
    return Card(
        child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Center(child: RatingUtils.convertRatingToTextColour(grade)),
      onTap: () {
        Navigator.pop(context);
        bloc.rateTrack(grade);
      },
      //),
    ));
  }
}
