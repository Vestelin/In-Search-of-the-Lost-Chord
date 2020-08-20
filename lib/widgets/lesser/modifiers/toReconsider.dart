import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/utils/ratingUtils.dart';

class ToReconsider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToReconsiderState();
  }
}

class _ToReconsiderState extends State<ToReconsider> {
  TrackBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<TrackBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bloc.switchModifier(TrackModifier.toReconsider),
      child: StreamBuilder<Track>(
          stream: bloc.trackStream,
          initialData: bloc.track,
          builder: (context, snapshot) {
            var data = snapshot.data;
            var hasToReconsider = data?.modifiers[TrackModifier.toReconsider];
            return Container(
                child: Icon(Icons.help,
                    color: hasToReconsider
                        ? RatingUtils.getColorByRating(data.rating)
                        : Colors.grey[700]));
          }),
    );
  }
}
