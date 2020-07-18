import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/addingTrackBloc.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';
import 'package:in_search_of_the_lost_chord/models/misc/cores.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingAnimatedListCore.dart';
import 'package:in_search_of_the_lost_chord/models/misc/ratingGrades.dart';
import 'package:in_search_of_the_lost_chord/models/utils/ratingUtils.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/rateTrack.dart';

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

class CreateItemDialog<T extends INamed> extends NameManipulationDialog {
  CreateItemDialog(T Function(String) creater)
      : super((name) => Cores.currentTrackCore.addItem(creater(name)));
}

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
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
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
