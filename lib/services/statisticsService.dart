import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class StatisticsService {
  static ValueNotifier<List<Future>> futures = ValueNotifier<List<Future>>([
    StatisticsService.getReleasesCount(),
    StatisticsService.getTracksAmount(),
    StatisticsService.getReleaseWithBestMstrPercentage(),
    StatisticsService.getReleaseWithHighestTrackAmount(),
    StatisticsService.getReleaseWithHighestHistoryAmount(),
  ]);

  static void resetFutures() {
    /* futures.value[0] = getReleasesCount();
    futures.value[1] = getTracksAmount();
    futures.value[2] = getReleaseWithBestMstrPercentage();
    futures.value[3] = getReleaseWithHighestTrackAmount();
    futures.value[4] = getReleaseWithHighestHistoryAmount(); */
    futures.value = [
      StatisticsService.getReleasesCount(),
      StatisticsService.getTracksAmount(),
      StatisticsService.getReleaseWithBestMstrPercentage(),
      StatisticsService.getReleaseWithHighestTrackAmount(),
      StatisticsService.getReleaseWithHighestHistoryAmount(),
    ];
  }

  static Future<int> getReleasesCount() async {
    int releaseAmount = Database.releases.length;
    await Future.delayed(Duration(milliseconds: 4000));
    return Future.value(releaseAmount);
  }

  static Future<int> getTracksAmount() async {
    int trackAmount = 0;
    Database.releases
        .forEach((element) => trackAmount += element.tracks.length);
    await Future.delayed(Duration(milliseconds: 6000));
    return Future.value(trackAmount);
  }

  static String formatAndValidateText(String textToFormat, String textIfNull,
      int signLimit, String replaceOnOverSignLimit, List<String> suffix) {
    String properText;
    if (textToFormat != null) {
      if (textToFormat.length > signLimit)
        textToFormat =
            textToFormat.replaceRange(signLimit, null, replaceOnOverSignLimit);
      properText = textToFormat + ' - ' + suffix.join();
    } else
      properText = textIfNull;
    return properText;
  }

  static Future<String> getReleaseWithBestMstrPercentage() async {
    String releaseName;
    int percentage = 0;

    Database.releases.forEach((element) {
      int masterpieceAmount = 0;
      element.tracks.forEach((element) {
        if (element.rating == RatingGrades.masterpiece) masterpieceAmount++;
      });
      int currentPercentage =
          (masterpieceAmount * 100 ~/ element.tracks.length);
      if (currentPercentage > percentage) {
        releaseName = element.name;
        percentage = currentPercentage;
      }
    });
    String properText = formatAndValidateText(releaseName,
        'No masterpiece found', 14, '...', [percentage.toString(), '%']);
    await Future.delayed(Duration(milliseconds: 8000));
    return Future.value(properText);
  }

  static Future<String> getReleaseWithHighestTrackAmount() async {
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
        14, '...', [highestTrackAmount.toString()]);
    await Future.delayed(Duration(milliseconds: 10000));
    return Future.value(properText);
  }

  static Future<String> getReleaseWithHighestHistoryAmount() async {
    String releaseName;
    int highestHistoryAmount = 0;
    Database.releases.forEach(
      (element) {
        int currentHistoryAmount = element.historyOfRatings.length;
        if (element.tracks.length > highestHistoryAmount) {
          releaseName = element.name;
          highestHistoryAmount = currentHistoryAmount;
        }
      },
    );
    String properText = formatAndValidateText(releaseName, 'No tracks found',
        14, '...', [highestHistoryAmount.toString()]);
    await Future.delayed(Duration(milliseconds: 12000));
    return Future.value(properText);
  }
}
