import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';

class SetNameByDialog<T> {
  Function(String) onClick;
  TextEditingController nameController;

  AlertDialog setNameDialog() {
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
      actions: <Widget>[FlatButton(child: Text("Done"), onPressed: onClick(nameController.text),)],
    );
  }
}

class CreateItemDialog<T extends INamed> extends SetNameByDialog {
  List<INamed> collectionToAddItem;
  CreateItemDialog(this.collectionToAddItem, INamed Function(String) creater) {
    onClick = (String name) {
      collectionToAddItem.add(creater(name));
    };
  }
}