import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

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
    return AnimatedList(
      key: core.listKey,
      itemBuilder: (context, index, animation) =>
          core.buildItem(index, animation),
      initialItemCount:
          core.presentedList.length,
    );
  }
}
