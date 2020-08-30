import 'package:flutter/material.dart';
import 'dataManagement/JsonToFile.dart';
import 'dataManagement/database.dart';
import 'models/misc/cores.dart';
import 'models/release.dart';
import 'widgets/mainPageRelated/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database.dataManager = JsonToFile<List<Release>>();
  await Database.loadReleases();
  Cores.initializeCores();
  runApp(MainPage());
}
