import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrackDialog.dart';

enum RateTileType { ratingAlreadyExisting, ratingAtCreation }

abstract class RateTile extends StatelessWidget {
  final RatingGrades grade;
  RateTile(this.grade);
}

class ExistingTrackRateTile extends RateTile {
  ExistingTrackRateTile(grade) : super(grade);
  @override
  Widget build(BuildContext context) {
    final bloc = TrackBlocProvider.of(context).bloc;
    return Card(
        child: ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Center(
          child: RatingUtils.convertRatingToTextColour(grade),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        bloc.rateTrack(grade);
      },
    ));
  }
}

class NewTrackRateTile extends RateTile {
  NewTrackRateTile(grade) : super(grade);
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddingTrackBloc>(context);
    return Card(
        child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Center(child: RatingUtils.convertRatingToTextColour(grade)),
      onTap: () {
        bloc.changeCurrentGrade(grade);
      },
    ));
  }
}
