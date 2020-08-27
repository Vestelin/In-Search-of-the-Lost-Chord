import 'dart:async';
import 'dart:core';

import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';

class StatisticsService {
  static List<Future> futures = [
    StatisticsService.getReleasesCount(),
    StatisticsService.getTracksAmount(),
    StatisticsService.getReleaseWithBestMstrPercentage()
  ];

  static Future<int> getReleasesCount() async {
    int releaseAmount = Database.releases.length;
    await Future.delayed(Duration(milliseconds: 1000));
    return Future.value(releaseAmount);
  }

  static Future<int> getTracksAmount() async {
    int trackAmount = 0;
    Database.releases
        .forEach((element) => trackAmount += element.tracks.length);
    await Future.delayed(Duration(milliseconds: 1000));
    return Future.value(trackAmount);
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
    String combinedString;
    if (releaseName != null) {
      if (releaseName.length > 14)
        releaseName = releaseName.replaceRange(14, null, '...');
      combinedString = releaseName + ' - ' + percentage.toString() + '%';
    } else
      combinedString = 'No masterpiece found';
    await Future.delayed(Duration(milliseconds: 3000));
    return Future.value(combinedString);
  }
}
