 import 'package:in_search_of_the_lost_chord/models/release.dart';

class Database {
   static List<Release> releases = [Release.test(), Release("ziemniak"), Release("dwa ziemniaki")];

  void addRelease(Release release) {
    releases.add(release);
  } 
 }