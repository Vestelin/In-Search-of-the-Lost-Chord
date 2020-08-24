import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final double sizedBoxHeight = 12;

  final Color mainColor = /* Color(0xFF131316); */
      Colors.black45; //Color(0xFF1E1E24); // //Color(0xFF5F5F60);
  @override
  Widget build(BuildContext context) {
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
                      StatisticsRow(
                        statText: "Total releases",
                        data: "47",
                      ),
                      StatisticsRow(
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

class StatisticsRow extends StatelessWidget {
  StatisticsRow({
    Key key,
    @required this.statText,
    @required this.data,
  }) : super(key: key);

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
        Text(
          "$statText:\n$data",
          style: style,
        )
      ],
    );
  }
}
