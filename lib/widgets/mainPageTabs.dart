import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/mainPageManager.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

import 'lesser/addAlbumWindow.dart';
import 'lesser/releaseTile.dart';

class MainPageTabs extends StatefulWidget {
  final MainPageManager manager = MainPageManager();

  @override
  State<StatefulWidget> createState() {
    return _MainPageTabsState();
  }
}

class _MainPageTabsState extends State<MainPageTabs> {
  void onNavigationTap(int index) =>
      setState(() => widget.manager.selected = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text("In Search of the Lost Chord")),
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
                child: Icon(Icons.add)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text("Releases"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          )
        ],
        currentIndex: widget.manager.selected,
        onTap: onNavigationTap,
      ),
      body: widget.manager.getProperBody(),
    );
  }
}

class Testwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestWidgetState();
  }
}

class TestWidgetState extends State<Testwidget> {
  GlobalKey<AnimatedListState> albumsKey = GlobalKey<AnimatedListState>();
  static RatingAnimatedListCore<Release> core;
  dynamic d = ["XXX", "YYY", "ZZZ"];
  int f = 0;

  TestWidgetState() {
    core = RatingAnimatedListCore<Release>(
        (s) => ReleaseTile(s, UniqueKey()), albumsKey, Database.releases, true);
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: albumsKey,
      itemBuilder: (context, index, animation) =>
          core.buildItem(index, animation),
      initialItemCount: Database.releases.length,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
