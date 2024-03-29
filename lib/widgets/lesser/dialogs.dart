import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/trackBloc.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/trackListRelated/rateTrack.dart';

import '../trackListRelated/tracksView.dart';

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
        autofocus: true,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: const InputDecoration(
            labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
      ),
      actions: <Widget>[
        TextButton(
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
  const AddTrackDialog();

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
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: nameController,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                  labelText: "Name", labelStyle: const TextStyle(fontSize: 16)),
            ),
            Container(
              height: 15,
            ),
            Container(
              width: 300,
              child: StreamBuilder<RatingGrades>(
                  stream: bloc.stream,
                  initialData: RatingGrades.notRated,
                  builder: (context, snapshot) {
                    var grade = snapshot.data;
                    if (grade == null) return Container();
                    return RateTrack(RatingUtils.getNewTrackRateTiles(), false);
                  }),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
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
                child: RateTrack(RatingUtils.getExistingTrackRateTiles(), true),
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

  Release _releaseToAdd;

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
                TextButton(
                  child: const Text(
                    "Cancel",
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                    child: const Text("Create and Go"),
                    onPressed: () {
                      _addReleaseAndPushToTracksView(context);
                    }),
                TextButton(
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
    _addReleaseAndRemoveDialog(context, animate: false);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TracksView(_releaseToAdd)));
  }

  void _addReleaseAndRemoveDialog(BuildContext context, {bool animate: true}) {
    _addRelease(animate: animate);
    Navigator.pop(context);
  }

  void _addRelease({Release release, bool animate: true}) {
    _releaseToAdd = _createReleaseFromGivenValues();
    final Release releaseToAdd = release ?? _releaseToAdd;
    Cores.releaseListCore.addItem(releaseToAdd, animate: animate);
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

class RemoveItemDialog<T extends INamed> extends StatelessWidget {
  final void Function(T) removeFunction;
  final T item;
  RemoveItemDialog({this.item, this.removeFunction});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: Text("Are you sure, you want do delete ${item.name}?",
          style: const TextStyle(fontSize: 16)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              removeFunction(item);
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("No"))
      ],
    );
  }
}
