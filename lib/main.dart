import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/stackAnimationProvider.dart';
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
      home: StackAnimationProvider(child: StackOfStatisticsAndReleaseList()),
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
    extends State<StackOfStatisticsAndReleaseList> {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = StackAnimationProvider.ofState(context).controller;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isDismissed) {
          StackAnimationProvider.ofState(context).ignoreGesture.value = false;
          controller.reverse();
        }
      },
      child: Stack(
        children: [
          Statistics(),
          SafeArea(
              child: ValueListenableBuilder(
            valueListenable:
                StackAnimationProvider.ofState(context).ignoreGesture,
            builder: (BuildContext context, bool ignore, _) => IgnorePointer(
                ignoring: ignore, child: ReleasesWithAnimatedBuilder()),
          )),
        ],
      ),
    );
  }
}

class ReleasesWithAnimatedBuilder extends StatefulWidget {
  @override
  _ReleasesWithAnimatedBuilderState createState() =>
      _ReleasesWithAnimatedBuilderState();
}

class _ReleasesWithAnimatedBuilderState
    extends State<ReleasesWithAnimatedBuilder> {
  AnimationController controller;
  @override
  void initState() {
    controller = StackAnimationProvider.ofState(context).controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: StackAnimationProvider.ofState(context).controller,
      child: const MainPageTabs(),
      builder: (BuildContext context, Widget child) {
        double scale = 1 - (0.5 * controller.value);
        double translateHeight =
            (MediaQuery.of(context).size.height * 0.100 * controller.value);
        double translateWidth =
            (MediaQuery.of(context).size.width * 0.625 * controller.value);
        return Transform(
            transform: Matrix4.identity()
              ..translate(translateWidth, translateHeight)
              ..scale(scale),
            child: child);
      },
    );
  }
}
