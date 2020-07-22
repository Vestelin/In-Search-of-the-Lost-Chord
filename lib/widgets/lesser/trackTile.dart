import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';

import 'modifiers/toReconsider.dart';
import 'dialogs.dart';

class HistoryTrackTile extends StatelessWidget {
  final Track track;
  HistoryTrackTile(this.track);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(track.name,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18)),
      subtitle: RatingUtils.convertRatingToTextColour(track.rating),
    );
  }
}

class TrackTile extends StatefulWidget {
  final Track track;
  TrackTile(this.track, {key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TrackTileState();
  }
}

class _TrackTileState extends State<TrackTile> {
  TrackBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<TrackBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.3), color: Colors.grey[800]),
      child: Material(
        color: Colors.transparent,
        child: StreamBuilder<Track>(
            stream: bloc.trackStream,
            initialData: bloc.track,
            builder: (context, snapshot) {
              var data = snapshot.data;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(data.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18)),
                subtitle: RatingUtils.convertRatingToTextColour(data.rating),
                trailing: ToReconsider(),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(child: RateTrackDialog(bloc)),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChangeTrackNameDialog(
                      onClick: (String newName) => bloc.changeName(newName),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
