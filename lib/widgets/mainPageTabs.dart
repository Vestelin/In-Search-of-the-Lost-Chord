import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/possibleMainTabViews.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';

class MainPageTabs extends StatelessWidget {
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
}


class Testwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWidgetState();
  }
}

class TestWidgetState extends State<Testwidget> {
  GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  RatingAnimatedListCore<String> core;
  dynamic d = ["Kocham", "Cię", "Wilczku"];
  int f = 0;
    
  
  TestWidgetState() { 
    core = RatingAnimatedListCore<String>((s) => ListTile(title: Text(s), onTap: () {core.addItem(d[f]); f = f == 2 ? 0 : ++f;},), key,
        ["Mleeem"], false);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedList(key: key, itemBuilder: (context, index, animation) => core.buildItem(index, animation), initialItemCount: 1,);
  }

  @override
  void initState() {
    super.initState();
  }
}
