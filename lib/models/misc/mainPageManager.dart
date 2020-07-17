import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/releaseList.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/search.dart';

class MainPageManager {
  int selected;

  MainPageManager() {
    selected = 0;
  }

  static final mainPageWigets = [ReleaseList(), Search()];

  Widget getProperBody() {
    /* return IndexedStack(
        children: <Widget>[ReleaseList(), Search()], index: selected); */
    switch (selected) {
      case 0:
        return mainPageWigets[0];
        break;
      case 1:
        //return BlocProvider<SearchBloc>(child: Search(), bloc: SearchBloc());
        return mainPageWigets[1];
        break;
      default:
        return const Center(
          child: const Text(
              "Something unexpected happened, somehow you've managed to change to non existent tab"),
        );
    }
  }
}
