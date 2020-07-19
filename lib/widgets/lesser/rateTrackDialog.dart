import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrack.dart';

class RateTrackDialog extends StatelessWidget {
  final TrackBloc _bloc;
  RateTrackDialog(this._bloc);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      shouldDispose: false,
      bloc: _bloc,
      child: SizedBox(
        height: 100,
        width: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: RateTrack(RatingUtils.getExistingTrackRateTiles()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
