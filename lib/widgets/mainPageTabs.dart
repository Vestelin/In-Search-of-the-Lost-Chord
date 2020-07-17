import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/models/misc/mainPageManager.dart';
import 'lesser/addAlbumWindow.dart';

class MainPageTabs extends StatefulWidget {
  final MainPageManager manager = MainPageManager();

  @override
  State<StatefulWidget> createState() {
    return _MainPageTabsState();
  }
}

PageController controller = PageController();

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
                child: const Icon(Icons.add)),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music),
            title: const Text("Releases"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
          )
        ],
        currentIndex: widget.manager.selected,
        onTap: (index) => controller.jumpToPage(index), //onNavigationTap,
      ),
      body: BlocProvider<SearchBloc>(
          child: PageView(
            onPageChanged: onNavigationTap,
            controller: controller,
            children: MainPageManager.mainPageWigets

            /* child: widget.manager
                .getProperBody() */
            ,
          ), //Scaffold(body: widget.manager.getProperBody()),
          bloc: SearchBloc()),
    );
  }
}
