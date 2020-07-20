import 'dart:convert';

import 'package:in_search_of_the_lost_chord/models/release.dart';

class Database {
  static List<Release> releases = [
    Release.test(),
    Release("ziemniak"),
    Release("dwa ziemniaki")
  ];

  static Future<List<Release>> getReleasesByKeyword(String searchedPhrase) {
    List<Release> result;
    var keyword = searchedPhrase.toLowerCase();
    if (keyword != null)
      result = keyword.trim() != ""
          ? Database.releases
              .where((e) => e.name.toLowerCase().startsWith(keyword))
              .toList()
          : List<Release>();
    return Future.value(result);
  }

  static void addRelease(Release release) {
    releases.add(release);
  }
}
