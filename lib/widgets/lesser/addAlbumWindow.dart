import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/tracksView.dart';

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
                child: const Text(
                  "Add album",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  autofocus: true,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                      labelText: "Name",
                      labelStyle: const TextStyle(fontSize: 16)),
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
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      labelText: "Number of tracks",
                      labelStyle: const TextStyle(fontSize: 16)),
                ),
              ),
              ButtonBar(children: [
                FlatButton(
                  child: const Text(
                    "Cancel",
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: const Text("Create and Go"),
                    onPressed: () {
                      var releaseToAdd = Release.test();
                      Cores.releaseListCore.addItem(releaseToAdd);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TracksView(releaseToAdd)));
                    }),
                FlatButton(
                  child: const Text("Create"),
                  onPressed: () {
                    Navigator.pop(context);
                    Cores.releaseListCore.addItem(Release.test());
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
