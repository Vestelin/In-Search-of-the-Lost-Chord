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
  static const double _bottomPaddingValue = 6.0;
}

class ExistingTrackRateTile extends RateTile {
  ExistingTrackRateTile(grade) : super(grade);
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TrackBloc>(context);
    return Card(
        child: ListTile(
      title: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: RateTile._bottomPaddingValue),
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
    return StreamBuilder<RatingGrades>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          var data = snapshot.data;
          return Card(
              color: data == grade ? Color(0x99616161) : null,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Padding(
                  padding: const EdgeInsets.only(
                      bottom: RateTile._bottomPaddingValue),
                  child: Center(
                      child: RatingUtils.convertRatingToTextColour(grade)),
                ),
                onTap: () {
                  bloc.changeCurrentGrade(grade);
                },
              ));
        });
  }
}
