import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/possibleMainTabViews.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';

class MainPageTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("In Search of the Lost Chord")),
        ),
        bottomNavigationBar: TabBar(
          labelPadding: EdgeInsets.all(0),
          tabs: [
            TabBarContainer(const Icon(Icons.play_circle_outline), "Releases"),
            TabBarContainer(const Icon(Icons.mic), "Performers"),
            TabBarContainer(const Icon(Icons.library_music), "Genres"),
            /* Container(
              height: 40,
              child: Column(
                children: [
                  Icon(Icons.play_circle_outline),
                  Text("Releases"),
                ],
              ),
            ),
            Container(
              height: 40,
              child: Column(
                children: [
                  Icon(Icons.play_circle_outline),
                  Text("Releases"),
                ],
              ),
            ),
            Container(
              height: 40,
              child: Column(
                children: [
                  Icon(Icons.play_circle_outline),
                  Text("Releases"),
                ],
              ),
            ), */
            /* Tab(
              icon: Icon(Icons.play_circle_outline, size: 20,),
              //text: "Releases",
            ),
            Tab(
              icon: Icon(Icons.mic, size: 20), */
            //text: "Performers",
            //),
            /*  Tab(
              icon: Icon(Icons.library_music, size: 20),
              //child: Text("sda")
            ) */
          ],
        ),
      ),
      length: possibleMainTabViews.values.length,
    );
  }
}
