import 'dart:async';

import 'package:in_search_of_the_lost_chord/bloc/bloc.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';

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

  Future<void> addReleasesCountToStreamIncrementally() async {
    int releasesCount = getReleasesCount();
    for (int currentValue = 0; currentValue <= releasesCount; currentValue++) {
      await Future.delayed(Duration(milliseconds: 20));
      addToStream(StatisticsStreamControllers.releaseCount, currentValue);
    }
  }

  Future<void> addReleaseCountToStreamIncrementally() async {
    int releasesCount = getReleasesCount();
    for (int currentValue = 0; currentValue <= releasesCount; currentValue++) {
      await Future.delayed(Duration(milliseconds: 20));
      addToStream(StatisticsStreamControllers.releaseCount, currentValue);
    }
  }

  Future<void> addTrackCountToStreamIncrementally() async {
    int releasesCount = getTracksCount();
    for (int currentValue = 0; currentValue <= releasesCount; currentValue++) {
      await Future.delayed(Duration(milliseconds: 20));
      addToStream(StatisticsStreamControllers.releaseCount, currentValue);
    }
  }

  int getTracksCount() {}

  int getReleasesCount() {
    return 150; //Database.releases.length;
  }

  @override
  void dispose() {
    streamControllers.forEach((key, value) => value.close());
  }
}
