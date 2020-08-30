import 'package:flutter/material.dart';

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
