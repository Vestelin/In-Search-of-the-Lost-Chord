import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/search.dart';

class SearchBloc implements Bloc {
  List<Release> _releases;
  String searchedWord;
  List<Release> get releases => _releases;
  List<Release> actualFoundReleases;

  final StreamController<List<Release>> _searchController =
      StreamController<List<Release>>();

  Stream<List<Release>> get searchStream => _searchController.stream;

  Future<List<Release>> getReleasesByKeyword(String keyword) async {
    searchedWord = keyword;
    List<Release> tmpReleases;
    tmpReleases = await Database.getReleasesByKeyword(searchedWord);
    return tmpReleases;
  }

  void sinkReleasesByKeyword(String keyword) async {
    searchedWord = keyword;
    List<Release> tmpReleases;
    tmpReleases = await Database.getReleasesByKeyword(searchedWord);
    actualFoundReleases = tmpReleases;
    _searchController.sink.add(tmpReleases);
  }

  @override
  void dispose() {
    _searchController.close();
  }
}
