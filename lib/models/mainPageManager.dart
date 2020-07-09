import 'package:flutter/cupertino.dart';
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

  Widget getProperBody() {
    switch (selected) {
      case 0:
        return ReleaseList();
      case 1:
        return BlocProvider<SearchBloc>(child: Search(), bloc: SearchBloc());
      default:
        return const Center(
          child: const Text(
              "Something unexpected happened, somehow you've managed to change to non existent tab"),
        );
    }
  }
}
