import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageTabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In The Search of The Lost Chord',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        accentColor: Colors.grey,
      ),
      home: MainPageTabs(),
    );
  }
}
