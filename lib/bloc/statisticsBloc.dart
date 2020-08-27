import 'dart:async';
import 'dart:collection';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';

enum StatisticsStreamControllers {
  releaseCount,
  trackCount,
  masterpiecePercentage,
  highestTrackAmount,
  highestHistoryAmount,
}

class StatisticsBloc extends Bloc {
  Map<StatisticsStreamControllers, StreamController> streamControllers = {};

  List<Type> _acceptedTypes = [String, int];

  StatisticsBloc() {
    streamControllers[StatisticsStreamControllers.releaseCount] =
        StreamController<int>();
    streamControllers[StatisticsStreamControllers.trackCount] =
        StreamController<int>();
    streamControllers[StatisticsStreamControllers.masterpiecePercentage] =
        StreamController<String>();
    streamControllers[StatisticsStreamControllers.highestTrackAmount] =
        StreamController<String>();
    streamControllers[StatisticsStreamControllers.highestHistoryAmount] =
        StreamController<String>();
  }

  void addToStream(StatisticsStreamControllers controller, dynamic value) {
    if (_acceptedTypes.contains(value.runtimeType)) {
      streamControllers[controller].sink.add(value);
    }
  }

/*   Future<void> addReleasesCountToStreamIncrementally() async {
    int releasesCount = getReleasesCount();
    for (int currentValue = 0; currentValue <= releasesCount; currentValue++) {
      //await Future.delayed(Duration(milliseconds: 10));
      addToStream(StatisticsStreamControllers.releaseCount, currentValue);
    }
  } */

  int _tracksCount = 0;

  Future<void> addTrackCountToStreamIncrementally() async {
    addTrackCount();
    for (int currentValue = 0; currentValue <= _tracksCount; currentValue++) {
      //await Future.delayed(Duration(milliseconds: 2));
      addToStream(StatisticsStreamControllers.trackCount, currentValue);
    }
  }

  Future<void> addTrackCount() async {
    Database.releases.forEach((element) {
      _tracksCount += element.tracks.length;
    });
  }

/*   int getReleasesCount() {
    return 150; //Database.releases.length;
  } */

  Future<void> getReleaseWithHighestTrackAmount() async {
    String name;
    int trackAmount = 0;
    Database.releases.forEach(
      (element) {
        addToStream(
            StatisticsStreamControllers.highestTrackAmount, element.name);
        if (trackAmount < element.tracks.length) {
          name = element.name;
          trackAmount = element.tracks.length;
        }
        Future.delayed(Duration(milliseconds: 2000));
      },
    );
    addToStream(StatisticsStreamControllers.highestTrackAmount, name);
  }

  @override
  void dispose() {
    streamControllers.forEach((key, value) => value.close());
  }
}
