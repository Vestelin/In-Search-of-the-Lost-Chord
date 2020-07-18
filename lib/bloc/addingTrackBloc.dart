import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class AddingTrackBloc extends Bloc {
  String name;
  RatingGrades currentGrade;
  TrackListBloc trackListbloc;

  StreamController<RatingGrades> _gradeController =
      StreamController<RatingGrades>.broadcast();

  Stream<RatingGrades> get stream => _gradeController.stream;

  void changeCurrentGrade(RatingGrades grade) {
    currentGrade = grade;
    _gradeController.sink.add(grade);
  }

  @override
  void dispose() {
    _gradeController.close();
  }
}
