import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

class SearchManager {
  String searchedWord;

  Future<List<Release>> findReleaseFuture;
  SearchManager() {
    searchedWord = "zie";
    findReleasesAsFuture = Future(findReleases);
  }

  Future<List<Release>> findReleasesAsFuture;

  List<Release> findReleases() {
    List<Release> result;
    var keyword = searchedWord.toLowerCase();
    if (searchedWord != null)
      result = searchedWord.trim() != ""
          ? Database.releases
              .where((e) => e.name.toLowerCase().startsWith(keyword))
              .toList()
          : List<Release>();
    return result;
  }

  Future<List<Release>> findRelease() async { 
    return await findReleasesAsFuture;
  } 

  /* List<Release> findReleases() { 
    return (searchedWord != null || searchedWord != "") ? Database.releases.where((e) => e.name.startsWith(searchedWord)).toList() : List<Release>();
  } */
}
