import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

import '../tracksView.dart';
import 'dialogs.dart';

class ReleaseTile extends StatefulWidget {
  final Release release;
  ReleaseTile(this.release, Key key) : super(key: key);
  ReleaseTile.noKey(this.release);
  @override
  State<StatefulWidget> createState() {
    return _ReleaseTileState();
  }
}

class _ReleaseTileState extends State<ReleaseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(), color: Colors.grey[800]),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          title: Text(widget.release.name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18)),
          trailing: Text(widget.release.tracks.length.toString()),
          onTap: () {
            Database.saveReleases();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TracksView(widget.release)));
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) =>
                    ChangeNameDialog(widget.release, Cores.releaseListCore));
          },
        ),
      ),
    );
  }
}
