import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrack.dart';

class TrackBlocProvider extends InheritedWidget {
  final TrackBloc bloc;
  TrackBlocProvider({@required this.bloc, child}) : super(child: child);
  static TrackBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TrackBlocProvider>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
}

class RateTrackDialog extends StatelessWidget {
  final TrackBloc _bloc;
  RateTrackDialog(this._bloc);
  @override
  Widget build(BuildContext context) {
    return TrackBlocProvider(
      bloc: _bloc,
      child: SizedBox(
        height: 60,
        width: 200,
        child: Column(
          children: <Widget>[
            Center(
              child: RateTrack(RatingUtils.getExistingTrackRateTiles()),
            )
          ],
        ),
      ),
    );
  }
}
