import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';

class ToReconsider extends StatefulWidget {
  final List<TrackModifier> modifiers;
  ToReconsider(this.modifiers);

  @override
  State<StatefulWidget> createState() {
    return _ToReconsiderState(modifiers);
  }
}

class _ToReconsiderState extends State<ToReconsider> {
  bool selected;
  _ToReconsiderState(List<TrackModifier> modifiers) {
    selected = modifiers.contains(TrackModifier.toReconsider);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: Container(
        child: Icon(Icons.help, color: selected ? Colors.blue : Colors.grey),
      ),
    );
  }
}
