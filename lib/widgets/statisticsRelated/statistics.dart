import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/services/statisticsService.dart';
import 'package:in_search_of_the_lost_chord/widgets/statisticsRelated/statisticsRow.dart';

import '../lesser/jumpingDotsProgressIndicator.dart';

class Statistics extends StatelessWidget {
  final double sizedBoxHeight = 12;
  static StatisticsService statisticsService = StatisticsService();
  final Color mainColor = Colors.black45;
  final JumpingDotsProgressIndicator indicator =
      const JumpingDotsProgressIndicator(
    dotSpacing: 0.5,
    color: Colors.white70,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            statisticsService.setFutures();
            return Future.delayed(Duration(milliseconds: 150));
          },
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                color: mainColor,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: ValueListenableBuilder<List<Future>>(
                    valueListenable: statisticsService.futures,
                    builder: (context, futures, _) => Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatisticsRow<int>(
                          statText: "Total releases",
                          future: futures[0],
                          indicator: indicator,
                        ),
                        StatisticsRow<int>(
                          statText: "Total tracks",
                          future: futures[1],
                          indicator: indicator,
                        ),
                        StatisticsRow<String>(
                          statText: "Highest track amount",
                          future: futures[2],
                          indicator: indicator,
                        ),
                        StatisticsRow<String>(
                          statText: "Highest history amount",
                          future: futures[3],
                          indicator: indicator,
                        ),
                        StatisticsRow<String>(
                          statText: "Highest masterpiece percentage",
                          future: futures[4],
                          indicator: indicator,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
