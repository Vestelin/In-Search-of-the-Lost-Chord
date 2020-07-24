import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrack.dart';

import '../tracksView.dart';

abstract class NameManipulationDialog<T> extends StatelessWidget {
  final Function(String) onClick;
  final TextEditingController nameController = TextEditingController();

  NameManipulationDialog(this.onClick);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Set name"),
      content: TextField(
        controller: nameController,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: const InputDecoration(
            labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text("Done"),
          onPressed: () {
            onClick(nameController.text);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

/* class CreateItemDialog<T extends INamed> extends NameManipulationDialog {
  CreateItemDialog(T Function(String) creater)
      : super((name) => Cores.currentTrackCore.addItem(creater(name)));
} */

class AddTrackDialog<Track> extends StatefulWidget {
  AddTrackDialog();

  @override
  _AddTrackDialogState<Track> createState() => _AddTrackDialogState<Track>();
}

class _AddTrackDialogState<Track> extends State<AddTrackDialog<Track>> {
  final TextEditingController nameController = TextEditingController();
  AddingTrackBloc bloc;

  _AddTrackDialogState();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddingTrackBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: nameController,
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
                labelText: "Name", labelStyle: const TextStyle(fontSize: 16)),
          ),
          Container(
            height: 15,
          ),
          StreamBuilder<RatingGrades>(
              stream: bloc.stream,
              initialData: RatingGrades.notRated,
              builder: (context, snapshot) {
                var grade = snapshot.data;
                if (grade == null) return Container();
                return RateTrack(RatingUtils.getNewTrackRateTiles());
              })
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text("Done"),
          onPressed: () {
            String trimmedTypedName = nameController.text.trim();
            String properName =
                trimmedTypedName == "" ? "Unnamed Track" : trimmedTypedName;
            bloc.name = properName;
            bloc.finalizeAdding();
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

class ChangeNameDialog<T extends INamed> extends NameManipulationDialog {
  final T item;
  ChangeNameDialog(this.item, RatingAnimatedListCore core)
      : super((name) {
          String correctName = name.trim() != "" ? name : item.name;
          core.listState.setState(() => item.name = correctName);
        });
}

class ChangeTrackNameDialog extends NameManipulationDialog {
  ChangeTrackNameDialog({onClick}) : super(onClick);
}

class RateTrackDialog extends StatelessWidget {
  final TrackBloc _bloc;
  RateTrackDialog(this._bloc);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      shouldDispose: false,
      bloc: _bloc,
      child: SizedBox(
        height: 220,
        width: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: RateTrack(
                  RatingUtils.getExistingTrackRateTiles(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
                      _addReleaseAndRemoveDialog(context),
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
                      _addReleaseAndPushToTracksView(context);
                    }),
                FlatButton(
                  child: const Text("Create"),
                  onPressed: () {
                    _addReleaseAndRemoveDialog(context);
                  },
                )
              ])
            ]),
          ),
        ),
      ],
    );
  }

  void _addReleaseAndPushToTracksView(BuildContext context) {
    Release releaseToAdd = _createReleaseFromGivenValues();
    _addReleaseAndRemoveDialog(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TracksView(releaseToAdd)));
  }

  void _addReleaseAndRemoveDialog(BuildContext context) {
    Navigator.pop(context);
    _addRelease();
  }

  void _addRelease({Release release}) {
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
