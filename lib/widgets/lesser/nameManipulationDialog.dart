import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/ratingAnimatedListCore.dart';

abstract class NameManipulationDialog<T> extends StatelessWidget {
  final Function(String) onClick;
  final TextEditingController nameController = TextEditingController();

  NameManipulationDialog(this.onClick);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Set name"),
      content: TextField(
        controller: nameController,
        textInputAction: TextInputAction.done,
        style: TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
            labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Done"),
          onPressed: () {
            onClick(nameController.text);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class CreateItemDialog<T extends INamed> extends NameManipulationDialog {
  CreateItemDialog(T Function(String) creater)
      : super((name) => Cores.currentTrackCore.addItem(creater(name)));
}

class ChangeNameDialog<T extends INamed> extends NameManipulationDialog {
  final T item;
  ChangeNameDialog(this.item, RatingAnimatedListCore core)
      : super((name) {
          item.name = name;
          core.listState.setState(() => item.name = name);
        });
}
