import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

class SearchBloc implements Bloc {
  List<Release> _releases;
  List<Release> get releases => _releases;

  final StreamController<List<Release>> _searchController =
      StreamController<List<Release>>();

  Stream<List<Release>> get searchStream => _searchController.stream;

  void getReleasesByKeyword(String keyword) async {
    List<Release> tmpReleases;
    tmpReleases = await Database.getReleasesByKeyword(keyword);
    _searchController.sink.add(tmpReleases);
  }

  @override
  void dispose() {
    _searchController.close();
  }
}
