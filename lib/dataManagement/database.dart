import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'IDataManager.dart';

class Database {
  static List<Release> releases;

  static IDataManager<List<Release>> dataManager;

  static Future<void> loadReleases() async {
    List<dynamic> decodedData = await dataManager.load();
    releases = decodedData?.map((e) => Release.fromJson(e))?.toList() ?? [];
  }

  static Future<void> saveReleases() async {
    dataManager.save(releases);
  }

  static Future<List<Release>> getReleasesByKeyword(String searchedPhrase) {
    List<Release> result;
    var keyword = searchedPhrase.toLowerCase();
    if (keyword != null)
      result = keyword.trim() != ""
          ? Database.releases
              .where((e) => e.name.toLowerCase().contains(keyword))
              .toList()
          : [];
    return Future.value(result);
  }

  static void addRelease(Release release) {
    releases.add(release);
  }
}
