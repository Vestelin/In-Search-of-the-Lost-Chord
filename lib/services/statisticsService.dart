import 'dart:core';

import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class StatisticsService {
  ValueNotifier<List<Future>> futures;

  static const int _milisecondsForFirst = 1000;
  static const double _milisecondsModifierForNextOnes = 0.2;

  StatisticsService() {
    futures = ValueNotifier<List<Future>>([]);
    setFutures();
  }

  void setFutures() {
    futures.value = [
      getReleasesCount(),
      getTracksAmount(),
      getReleaseWithHighestTrackAmount(),
      getReleaseWithHighestHistoryAmount(),
      getUnfinishedRating(),
    ];
  }

  Future<int> getReleasesCount() async {
    int positionOnList = 1;
    int releaseAmount = Database.releases.length;
    await Future.delayed(Duration(milliseconds: countDuration(positionOnList)));
    return Future.value(releaseAmount);
  }

  Future<int> getTracksAmount() async {
    int positionOnList = 2;
    int trackAmount = 0;
    Database.releases
        .forEach((element) => trackAmount += element.tracks.length);
    await Future.delayed(Duration(milliseconds: countDuration(positionOnList)));
    return Future.value(trackAmount);
  }

  Future<String> getReleaseWithHighestTrackAmount() async {
    int positionOnList = 3;
    String releaseName;
    int highestTrackAmount = 0;
    Database.releases.forEach(
      (element) {
        int currentTrackAmount = element.tracks.length;
        if (element.tracks.length > highestTrackAmount) {
          releaseName = element.name;
          highestTrackAmount = currentTrackAmount;
        }
      },
    );
    String properText = formatAndValidateText(releaseName, 'No tracks found',
        14, '...', [' - ', highestTrackAmount.toString()]);
    await Future.delayed(Duration(milliseconds: countDuration(positionOnList)));
    return Future.value(properText);
  }

  Future<String> getReleaseWithHighestHistoryAmount() async {
    int positionOnList = 4;
    String releaseName;
    int highestHistoryAmount = 0;
    Database.releases.forEach(
      (element) {
        int currentHistoryAmount = element.historyOfRatings.length;
        if (element.historyOfRatings.length > highestHistoryAmount) {
          releaseName = element.name;
          highestHistoryAmount = currentHistoryAmount;
        }
      },
    );
    String properText = formatAndValidateText(releaseName, 'No history found',
        26, '...', [' - ', highestHistoryAmount.toString()]);
    await Future.delayed(Duration(milliseconds: countDuration(positionOnList)));
    return Future.value(properText);
  }

  Future<String> getUnfinishedRating() async {
    int positionOnList = 5;
    String releaseName;

    Database.releases.forEach(
      (element) {
        if (element.tracks
            .any((element) => element.rating != RatingGrades.notRated)) {
          releaseName = element.name;
        }
      },
    );
    String properText = formatAndValidateText(
        releaseName, 'No unfinished ratings found', 26, '...', ['']);
    await Future.delayed(Duration(milliseconds: countDuration(positionOnList)));
    return Future.value(properText);
  }

  String formatAndValidateText(String textToFormat, String textIfNull,
      int signLimit, String replaceOnOverSignLimit, List<String> suffix) {
    String properText;
    if (textToFormat != null) {
      if (textToFormat.length > signLimit)
        textToFormat =
            textToFormat.replaceRange(signLimit, null, replaceOnOverSignLimit);
      properText = textToFormat + suffix.join();
    } else
      properText = textIfNull;
    return properText;
  }

  int countDuration(int positionOnList) {
    int time = _milisecondsForFirst +
        (_milisecondsForFirst *
                _milisecondsModifierForNextOnes *
                positionOnList)
            .toInt();
    return time;
  }
}
