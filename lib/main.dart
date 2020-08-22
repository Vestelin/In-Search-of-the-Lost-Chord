import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageTabs.dart';
import 'package:in_search_of_the_lost_chord/widgets/statistics.dart';

import 'dataManagement/JsonToFile.dart';
import 'dataManagement/database.dart';
import 'models/misc/cores.dart';
import 'models/release.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database.dataManager = JsonToFile<List<Release>>();
  await Database.loadReleases();
  Cores.initializeCores();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'In Search of the Lost Chord',
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.grey,
            accentColor: Colors.grey,
            textTheme: TextTheme(bodyText2: const TextStyle(fontSize: 18))),
        home: StackOfStatisticsAndReleaseList() //MainPageTabs(),
        );
  }
}

class StackOfStatisticsAndReleaseList extends StatefulWidget {
  const StackOfStatisticsAndReleaseList({
    Key key,
  }) : super(key: key);

  @override
  _StackOfStatisticsAndReleaseListState createState() =>
      _StackOfStatisticsAndReleaseListState();
}

class _StackOfStatisticsAndReleaseListState
    extends State<StackOfStatisticsAndReleaseList>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          controller.isDismissed ? controller.forward() : controller.reverse(),
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            double scale = 1 - (0.5 * controller.value);
            double translateHeight =
                (MediaQuery.of(context).size.height * 0.125 * controller.value);
            double translateWidth =
                (MediaQuery.of(context).size.width * 0.625 * controller.value);
            return Stack(
              children: [
                Statistics(),
                Transform(
                  child: SafeArea(child: MainPageTabs()),
                  transform: Matrix4.identity()
                    ..translate(translateWidth, translateHeight)
                    ..scale(scale),
                )
              ],
            );
          }),
    );
  }
}
