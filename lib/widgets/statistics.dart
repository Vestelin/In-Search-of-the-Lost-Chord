import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/statisticsBloc.dart';

class Statistics extends StatelessWidget {
  final double sizedBoxHeight = 12;

  final Color mainColor = /* Color(0xFF131316); */
      Colors.black45; //Color(0xFF1E1E24); // //Color(0xFF5F5F60);

  @override
  Widget build(BuildContext context) {
    StatisticsBloc bloc = BlocProvider.of<StatisticsBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => bloc.addReleasesCountToStreamIncrementally());
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
                    children: [
                      StatisticsRow<int>(
                        statText: "Total releases",
                        data: "47",
                        stream: bloc
                            .streamControllers[
                                StatisticsStreamControllers.releaseCount]
                            .stream,
                      ),
                      StatisticsRow<int>(
                        statText: "Total releases",
                        data: "47",
                        stream: bloc
                            .streamControllers[
                                StatisticsStreamControllers.trackCount]
                            .stream,
                      ),
                      /* StatisticsRow(
                        statText: "Total tracks",
                        data: "642",
                      ),
                      StatisticsRow(
                        statText: "Most frequent rate",
                        data: "Very Good",
                      ),
                      StatisticsRow(
                        statText: "Album with most tracks",
                        data: "Mellon Collie and The Infinite Sadness",
                      ),
                      StatisticsRow(
                        statText: "Album with most masterpieces",
                        data: "Neon Bible",
                      ), */
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
    @required this.data,
    this.stream,
  }) : super(key: key);

  final Stream stream;
  final Color iconColor = Colors.blueGrey[300];
  final String statText;
  //final Function dataFunction;
  final String data;
  final TextStyle style = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chevron_right, color: iconColor),
        StreamBuilder<T>(
            stream: stream,
            builder: (context, snapshot) {
              var dataa = snapshot.data;
              var dataToShow = dataa ?? 'No data';
              return Text(
                "$statText:\n$dataToShow", //$data",
                style: style,
              );
            })
      ],
    );
  }
}
