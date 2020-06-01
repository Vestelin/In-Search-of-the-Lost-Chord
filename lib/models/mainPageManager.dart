import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/searchManager.dart';
import 'package:in_search_of_the_lost_chord/widgets/inherited/searchProvider.dart';
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
        return SearchProvider(SearchManager(), child: Search());
      default:
        return const Center(
          child: const Text(
              "Something unexpected happened, somehow you've managed to change to non existent tab"),
        );
    }
  }
}
