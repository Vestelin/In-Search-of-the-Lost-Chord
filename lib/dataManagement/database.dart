import 'dart:convert';

import 'package:in_search_of_the_lost_chord/models/release.dart';

import 'IDataManager.dart';

class Database {
  static List<Release> releases = [
    Release.test(),
    Release("ziemniak"),
    Release("dwa ziemniaki")
  ];

  static IDataManager<List<Release>> dataManager;

  static void loadReleases() async {
    List<Map<String, dynamic>> decodedData = await dataManager.load();
    releases = decodedData?.map((e) => Release.fromJson(e))?.toList() ??
        List<Release>();
  }

  static void saveReleases() async {
    dataManager.save(releases);
  }

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
