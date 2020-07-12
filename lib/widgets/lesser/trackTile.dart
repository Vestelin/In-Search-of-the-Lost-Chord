import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/rateBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrackDialog.dart';

import 'modifiers/toReconsider.dart';
import 'nameManipulationDialog.dart';

class TrackTile extends StatefulWidget {
  final Track track;
  TrackTile(this.track);
  @override
  State<StatefulWidget> createState() {
    return _TrackTileState();
  }
}

class _TrackTileState extends State<TrackTile> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RateBloc>(context);
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 0.3)),
      child: Ink(
        color: Colors.grey[800],
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(widget.track.name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18)),
          subtitle: StreamBuilder<RatingGrades>(
              stream: bloc.rateStream,
              builder: (context, snapshot) {
                final rating = snapshot.data;
                if (rating == null)
                  return RatingUtils.convertRatingToTextColour(
                      RatingGrades.notRated);
                return RatingUtils.convertRatingToTextColour(
                    widget.track.rating);
              }),
          trailing: ToReconsider(widget.track.modifiers, widget.track.rating),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: RateTrackDialog(bloc)),
            );
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) =>
                    ChangeNameDialog(widget.track, Cores.currentTrackCore));
          },
        ),
      ),
    );
  }
}
