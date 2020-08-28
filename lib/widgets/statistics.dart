import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/statisticsBloc.dart';
import 'package:in_search_of_the_lost_chord/services/statisticsService.dart';

import 'lesser/jumpingDotsProgressIndicator.dart';

class Statistics extends StatelessWidget {
  final double sizedBoxHeight = 12;

  final Color mainColor = /* Color(0xFF131316); */
      Colors.black45; //Color(0xFF1E1E24); // //Color(0xFF5F5F60);
  final JumpingDotsProgressIndicator indicator = JumpingDotsProgressIndicator(
    dotSpacing: 0.5,
    color: Colors.white70,
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    /*  StatisticsBloc bloc = BlocProvider.of<StatisticsBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //bloc.addReleasesCountToStreamIncrementally();
      bloc.addTrackCountToStreamIncrementally();
      bloc.getReleaseWithHighestTrackAmount();
    }); */
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: mainColor,
          child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //JumpingDotsProgressIndicator()
                      StatisticsRow<int>(
                        statText: "Total releases",
                        future: StatisticsService.futures[0],
                        indicator: indicator,
                      ),
                      StatisticsRow<int>(
                        statText: "Total tracks",
                        future: StatisticsService.futures[1],
                        indicator: indicator,
                      ),
                      StatisticsRow<String>(
                        statText: "Most frequent rate",
                        future: StatisticsService.futures[2],
                        indicator: indicator,
                      ),
                      StatisticsRow<String>(
                        statText: "Highest track amount",
                        future: StatisticsService.futures[3],
                        indicator: indicator,
                      ),
                      StatisticsRow<String>(
                        statText: "Highest history amount",
                        future: StatisticsService.futures[4],
                        indicator: indicator,
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class StatisticsRow<T> extends StatelessWidget {
  StatisticsRow({
    Key key,
    @required this.statText,
    @required this.future,
    @required this.indicator,
  }) : super(key: key);

  final Future<T> future;
  final Widget indicator;
  final Color iconColor = Colors.blueGrey[300];
  final String statText;
  final TextStyle style = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chevron_right, color: iconColor),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$statText:",
              style: style,
            ),
            FutureBuilder<T>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: indicator,
                    );
                  else
                    return Text(snapshot.data.toString(),
                        style: TextStyle(fontSize: 16));
                }),
          ],
        )
      ],
    );
  }
}
