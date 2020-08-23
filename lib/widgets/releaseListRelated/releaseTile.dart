import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

import '../trackListRelated/tracksView.dart';
import '../lesser/dialogs.dart';

class ReleaseTile extends StatefulWidget {
  final Release release;
  const ReleaseTile(this.release, {Key key}) : super(key: key);
  const ReleaseTile.noKey(this.release);
  @override
  State<StatefulWidget> createState() {
    return _ReleaseTileState();
  }
}

class _ReleaseTileState extends State<ReleaseTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.only(top: 1),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          title: Text(widget.release.name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2),
          trailing: Text(widget.release.tracks.length.toString(),
              style: Theme.of(context).textTheme.bodyText2),
          onTap: () {
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
      //),
    );
  }
}
