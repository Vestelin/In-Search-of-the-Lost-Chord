import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/rateBloc.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrack.dart';

class RateTrackDialog extends StatelessWidget {
  final RateBloc bloc;
  RateTrackDialog(this.bloc);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 60,
      width: 200,
      child: Column(
        children: <Widget>[
          /*  Center(
            child: const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Rate track",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ), */
          Center(
            child: RateTrack(),
          )
        ],
      ),
    );
  }
}
