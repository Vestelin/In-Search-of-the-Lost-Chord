import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

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
    return ListTile(
      title: Text(widget.track.name),
      subtitle: Text(widget.track.rating.toString()),
    );
  }
}
