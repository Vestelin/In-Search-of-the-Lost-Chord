import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

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
          title: Text(widget.track.name),
          trailing: Text(widget.track.rating.toString()),
          subtitle: Row(children: <Widget>[ToReconsider(widget.track.modifiers)],),
          onTap: () {
              
          },
        ),
      ),
    );
  }
}
