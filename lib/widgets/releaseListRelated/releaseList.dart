import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

import '../../stackAnimationProvider.dart';
import '../lesser/dialogs.dart';

class ReleaseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReleaseListState();
  }
}

class _ReleaseListState extends State<ReleaseList> {
  RatingAnimatedListCore<Release> core;
  _ReleaseListState() {
    core = Cores.releaseListCore;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              StackAnimationProvider.ofState(context).shouldIgnoreGesture =
                  true;
              StackAnimationProvider.ofState(context).controller.forward();
            },
            child: const Text("In Search of the Lost Chord")),
        actions: <Widget>[
          SizedBox(
            width: 60,
            child: FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: AddAlbumWindow(),
                    ),
                  );
                },
                child: const Icon(Icons.add)),
          )
        ],
      ),
      body: AnimatedList(
        physics: const AlwaysScrollableScrollPhysics(),
        key: core.listKey,
        itemBuilder: (context, index, animation) =>
            core.buildItem(index, animation),
        initialItemCount: core.presentedList.length,
      ),
    );
  }
}
