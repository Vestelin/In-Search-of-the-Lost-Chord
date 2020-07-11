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
  TextEditingController nameController = TextEditingController();
  TextEditingController numberOfTracksController = TextEditingController();
  FocusNode numberFocus = FocusNode();

  final String errorText = "Please insert correct value";
  bool nameFail = false;
  bool numberFail = false;

  String name;
  int numberOfTracks;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 400,
          child: Card(
            child: Column(children: [
              const Padding(
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
                    labelStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  focusNode: numberFocus,
                  controller: numberOfTracksController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      labelText: "Number of tracks",
                      labelStyle: const TextStyle(fontSize: 16)),
                  onFieldSubmitted: (text) =>
                      addReleaseAndRemoveDialog(context),
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
                      addReleaseAndPushToTracksView(context);
                    }),
                FlatButton(
                  child: const Text("Create"),
                  onPressed: () {
                    addReleaseAndRemoveDialog(context);
                  },
                )
              ])
            ]),
          ),
        ),
      ],
    );
  }

  void addReleaseAndPushToTracksView(BuildContext context) {
    Release releaseToAdd = _createReleaseFromGivenValues();
    addReleaseAndRemoveDialog(context);
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TracksView(releaseToAdd)));
  }

  void addReleaseAndRemoveDialog(BuildContext context) {
    Navigator.pop(context);
    addRelease();
  }

  void addRelease({Release release}) {
    final Release releaseToAdd = release ?? _createReleaseFromGivenValues();
    Cores.releaseListCore.addItem(releaseToAdd);
  }

  Release _createReleaseFromGivenValues() {
    String name = nameController.text.trim();
    name = name != "" ? name : "Unnamed release";
    int numberOfTracks = getNumberOfTracksFromTextField() ?? 0;
    Release releaseToAdd = Release(name, numberOfTracks: numberOfTracks);
    return releaseToAdd;
  }

  int getNumberOfTracksFromTextField() {
    String numberofTracksInString = numberOfTracksController.text;
    return numberofTracksInString != null && numberofTracksInString.trim() != ""
        ? int.tryParse(numberofTracksInString)
        : 0;
  }
}
