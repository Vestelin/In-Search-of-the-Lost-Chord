import 'package:flutter/material.dart';

class TabBarContainer extends StatelessWidget {
  final Icon _icon;
  final String _text;
  TabBarContainer(this._icon, this._text);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_icon, Text(_text)],
        ));
  }
}
