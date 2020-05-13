import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';

import 'modifiers/toReconsider.dart';

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
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Ink(
        color: Colors.grey[800],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text(widget.track.name, softWrap: true, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18)),
          subtitle: RatingUtils.convertRatingToTextColour(widget.track.rating),
          trailing: ToReconsider(widget.track.modifiers, widget.track.rating),
          onTap: () {
              
          },
        ),
      ),
    );
  }
}
