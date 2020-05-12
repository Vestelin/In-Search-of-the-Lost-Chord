import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/releaseList.dart';

class MainPageManager {
  int selected;

  MainPageManager() {
    selected = 0;
  }

  Widget getProperBody() {
    switch (selected) {
      case 0:
        return ReleaseList();
      case 1:
        return Icon(Icons.camera);
      default:
        return Center(
          child: Text(
              "Something unexpected happened, somehow you've managed to change to non existent tab"),
        );
    }
  }
}
