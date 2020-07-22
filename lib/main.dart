import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageTabs.dart';

import 'dataManagement/JsonToFile.dart';
import 'dataManagement/database.dart';
import 'models/misc/cores.dart';
import 'models/release.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Database.dataManager = JsonToFile<
      List<Release>>(); //await JsonToFile.asyncFactory<List<Release>>()
  //as JsonToFile<List<Release>>;
  await Database.loadReleases();
  Cores.initializeCores();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
