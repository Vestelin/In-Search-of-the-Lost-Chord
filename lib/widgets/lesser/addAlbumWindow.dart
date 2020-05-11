import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/mainPageTabs.dart';

class AddAlbumWindow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
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
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      labelText: "Number of tracks",
                      labelStyle: TextStyle(fontSize: 16)),
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
                  onPressed: () {
                    TestWidgetState.core.addItem(Release.test());
                    Navigator.pop(context);
                  },
                )
              ])
            ]),
          ),
        ),
      ],
    );
  }
}
