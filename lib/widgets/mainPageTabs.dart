import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'releaseListRelated/releaseList.dart';
import 'releaseListRelated/search.dart';

class MainPageTabs extends StatefulWidget {
  const MainPageTabs();
  @override
  State<StatefulWidget> createState() {
    return _MainPageTabsState();
  }
}

class _MainPageTabsState extends State<MainPageTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body:
            /* GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          child: */
            BlocProvider<SearchBloc>(
          bloc: SearchBloc(),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [ReleaseList(), Search()],
          ),
        ),
        //),
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
