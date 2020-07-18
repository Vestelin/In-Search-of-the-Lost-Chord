import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackListBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

class AddingTrackBloc extends Bloc {
  String name;
  RatingGrades currentGrade;
  TrackListBloc trackListBloc;

  AddingTrackBloc({this.trackListBloc});

  StreamController<RatingGrades> _gradeController =
      StreamController<RatingGrades>.broadcast();

  Stream<RatingGrades> get stream => _gradeController.stream;

  void changeCurrentGrade(RatingGrades grade) {
    currentGrade = grade;
    _gradeController.sink.add(grade);
  }

  void finalizeAdding() {
    Track track = Track(name, rating: currentGrade);
    trackListBloc.addTrack(track);
  }

  @override
  void dispose() {
    _gradeController.close();
  }
}
