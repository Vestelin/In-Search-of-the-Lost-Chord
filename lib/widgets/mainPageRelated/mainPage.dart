import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageRelated/stackOfStatisticsAndReleaseList.dart';

import 'stackAnimationProvider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In Search of the Lost Chord',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
          accentColor: Colors.grey,
          textTheme: TextTheme(bodyText2: const TextStyle(fontSize: 18))),
      home: StackAnimationProvider(child: StackOfStatisticsAndReleaseList()),
    );
  }
}
