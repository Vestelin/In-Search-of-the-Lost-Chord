import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
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
                child: const Icon(Icons.add)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music, size: 20),
            activeIcon: const Icon(
              Icons.library_music,
            ),
            title: const Text("Releases",
                style: const TextStyle(color: Colors.grey)),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search, size: 20),
            activeIcon: const Icon(
              Icons.search,
            ),
            title: const Text("Search",
                style: const TextStyle(color: Colors.grey)),
          )
        ],
        currentIndex: widget.manager.selected,
        onTap: (index) => controller.jumpToPage(index),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: BlocProvider<SearchBloc>(
            child: PageView(
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: setSelectedToChosen,
                controller: controller,
                children: widget.manager.mainPageWidgets),
            bloc: SearchBloc()),
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
