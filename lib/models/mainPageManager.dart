import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/showReleaseList.dart';

class MainPageManager {
  int selected;

  MainPageManager() {
    selected = 0;
  }
 
  Widget getProperBody() {
    switch(selected) {
      case 0:
        return ShowReleaseList();
      case 1:
        return Icon(Icons.camera);
      default:
        return Placeholder();
    }
  }

  
}