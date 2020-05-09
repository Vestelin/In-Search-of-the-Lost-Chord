import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAlbumWindow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddAlbumWindowState();
  }
}

class _AddAlbumWindowState extends State<AddAlbumWindow> {
  TextEditingController nameController;
  TextEditingController numberOfTracksController;
  FocusNode numberFocus;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 400,
          child: Card(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add album",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),  
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  autofocus: true,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Name"),
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: numberFocus,
                  controller: numberOfTracksController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Number of tracks"),
                ),
              ),
              ButtonBar(children: [
                FlatButton(
                  child: Text(
                    "Cancel",
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Create and Go"),
                  onPressed: null,
                ),
                FlatButton(
                  child: Text("Create"),
                  onPressed: null,
                )
              ])
            ]),
          ),
        ),
      ],
    );
  }
}
