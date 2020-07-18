import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class AddingTrackBloc extends Bloc {
  String name;
  RatingGrades currentGrade;

  StreamController<RatingGrades> _gradeController =
      StreamController<RatingGrades>();

  Stream<RatingGrades> get stream => _gradeController.stream;

  void changeCurrentGrade(RatingGrades grade) {
    _gradeController.sink.add(grade);
  }

  @override
  void dispose() {
    _gradeController.close();
  }
}
