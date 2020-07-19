import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/releaseTile.dart';

import '../release.dart';

class Cores {
  static RatingAnimatedListCore releaseListCore;

  static initializeCores() {
    releaseListCore = RatingAnimatedListCore<Release>(
        (item) => ReleaseTile(item, ObjectKey(item)),
        GlobalKey<AnimatedListState>(),
        Database.releases,
        true);
  }
}
