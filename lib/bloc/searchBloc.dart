import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/search.dart';

class SearchBloc implements Bloc {
  List<Release> _releases;
  String searchedWord;
  List<Release> get releases => _releases;

  final StreamController<List<Release>> _searchController =
      StreamController<List<Release>>();

  Stream<List<Release>> get searchStream => _searchController.stream;

  Future<List<Release>> getReleasesByKeyword(String keyword) async {
    searchedWord = keyword;
    List<Release> foundReleases;
    foundReleases = await Database.getReleasesByKeyword(searchedWord);
    return foundReleases;
  }

  void sinkReleasesByKeyword(String keyword) async {
    List<Release> foundReleases = await getReleasesByKeyword(keyword);
    _searchController.sink.add(foundReleases);
  }

  @override
  void dispose() {
    _searchController.close();
  }
}
