import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/possibleMainTabViews.dart';
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

int f = 0;

class Testwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TestWidgetState();
  }
}

class TestWidgetState extends State<Testwidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedList(itemBuilder: (context, index, animation) => null);
  }

  @override
  void initState() {
    f++;
    super.initState();
  }
}
