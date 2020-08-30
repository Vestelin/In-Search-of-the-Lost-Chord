import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'releaseList.dart';
import 'search.dart';

class Releases extends StatefulWidget {
  const Releases();
  @override
  State<StatefulWidget> createState() {
    return _ReleasesState();
  }
}

class _ReleasesState extends State<Releases> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: BlocProvider<SearchBloc>(
          bloc: SearchBloc(),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [ReleaseList(), const Search()],
          ),
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            const TabBarContainer(const Icon(Icons.library_music), "Releases"),
            const TabBarContainer(const Icon(Icons.search), "Search"),
          ],
        ),
      ),
    );
  }
}
