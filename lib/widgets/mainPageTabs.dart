import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/tabBarContainer.dart';
import 'lesser/dialogs.dart';
import 'lesser/releaseList.dart';
import 'lesser/search.dart';

class MainPageTabs extends StatefulWidget {
  final MainPageManager manager = MainPageManager();

  @override
  State<StatefulWidget> createState() {
    return _MainPageTabsState();
  }
}

PageController controller = PageController();

class _MainPageTabsState extends State<MainPageTabs> {
  void setSelectedToChosen(int index) =>
      setState(() => widget.manager.selected = index);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          child: BlocProvider<SearchBloc>(
            bloc: SearchBloc(),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [ReleaseList(), Search()],
            ),
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

class MainPageManager {
  int selected;

  MainPageManager() {
    selected = 0;
  }

  final List<Widget> mainPageWidgets = [ReleaseList(), Search()];
}
