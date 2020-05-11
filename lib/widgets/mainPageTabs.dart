import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/mainPageManager.dart';
import 'package:in_search_of_the_lost_chord/models/misc/possibleMainTabViews.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';

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
 void onNavigationTap(int index) => setState(() => widget.manager.selected = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: const Text("In Search of the Lost Chord")),
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

/* class MainPageTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
            title:
                const Center(child: const Text("In Search of the Lost Chord")),
          ),
          bottomNavigationBar: TabBar(
            labelPadding: EdgeInsets.all(0),
            tabs: [
              TabBarContainer(
                  const Icon(Icons.play_circle_outline), "Releases"),
              TabBarContainer(const Icon(Icons.mic), "Performers"),
              TabBarContainer(const Icon(Icons.library_music), "Genres"),
            ],
          ),
          body: TabBarView(children: [
            Icon(Icons.accessible),
            Testwidget(),
            Icon(Icons.account_balance_wallet)
          ])),
      length: possibleMainTabViews.values.length,
    );
  }
} */

class Testwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWidgetState();
  }
}

class TestWidgetState extends State<Testwidget> {
  static GlobalKey<AnimatedListState> albumsKey = GlobalKey<AnimatedListState>();
  RatingAnimatedListCore<Release> core;
  dynamic d = ["XXX", "YYY", "ZZZ"];
  int f = 0;

  TestWidgetState() {
    core = RatingAnimatedListCore<Release>(
        (s) => ReleaseTile(s), albumsKey, Database.releases, true);
        
         /* ListTile(
              title: Text(s),
              onTap: () {
                /* core.addItem(d[f]);
                f = f == 2 ? 0 : ++f; */ 
                showDialog(context: context, builder: (context) => Dialog(child:SingleChildScrollView(child:AddAlbumWindow())));
              },
            ),
        key,
        ["Mleeem"],
        false); */
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
