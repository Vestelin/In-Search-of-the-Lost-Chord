import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/inherited/ratingListCoreProvider.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/releaseTile.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/showReleaseList.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageTabs.dart';

class MainPageManager {
  int selected;

  MainPageManager() {
    selected = 0;
  }
 
  Widget getProperBody() {
    switch(selected) {
      case 0:
        return ShowReleaseList();//RatingListCoreProvider(RatingAnimatedListCore<Release>((item) => ReleaseTile(item, ObjectKey(item)), GlobalKey<AnimatedListState>(), Database.releases, true), child: ShowReleaseList());
      case 1:
        return Icon(Icons.camera);
      default:
        return Placeholder();
    }
  }

  
}