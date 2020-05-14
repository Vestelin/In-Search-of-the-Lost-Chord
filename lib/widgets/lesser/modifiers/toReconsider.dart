import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/modifier.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';

class ToReconsider extends StatefulWidget {
  final List<TrackModifier> modifiers;
  final RatingGrades rating;
  ToReconsider(this.modifiers, this.rating);

  @override
  State<StatefulWidget> createState() {
    return _ToReconsiderState(modifiers, rating);
  }
}

class _ToReconsiderState extends State<ToReconsider> {
  bool selected;
  RatingGrades rating;
  _ToReconsiderState(List<TrackModifier> modifiers, this.rating) {
    selected = modifiers.contains(TrackModifier.toReconsider);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        if(selected) {
          widget.modifiers.remove(TrackModifier.toReconsider);
        }
        if(!selected) {
          widget.modifiers.add(TrackModifier.toReconsider);
        }
        selected = !selected;
      }),
      child: Container(
          child: Container(
              child: Icon(Icons.help,
                  color: selected ? RatingUtils.getColorByRating(rating) : Colors.grey[700]))),
    );
  }
}
