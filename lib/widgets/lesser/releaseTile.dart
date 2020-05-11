import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

class ReleaseTile extends StatefulWidget {
  final Release release;
  ReleaseTile(this.release);
  @override
  State<StatefulWidget> createState() {
    return _ReleaseTileState();
  }
}

class _ReleaseTileState extends State<ReleaseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Ink(
        color: Colors.grey[800],
        child: ListTile(
          title: Text(widget.release.name),
          trailing: Text(widget.release.tracks.length.toString()),
          onTap: () => null,
        ),
      ),
    );
  }
}
