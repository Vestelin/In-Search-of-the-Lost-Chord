import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/historyBloc.dart';
import 'package:in_search_of_the_lost_chord/models/tracksHistory.dart';
import 'package:in_search_of_the_lost_chord/widgets/trackListRelated/trackList.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HistoryBloc bloc = BlocProvider.of<HistoryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: <Widget>[
          FlatButton(
            child: const Icon(Icons.add),
            onPressed: () => bloc.addHistory(),
          )
        ],
      ),
      body: StreamBuilder<List<TracksHistory>>(
          stream: bloc.stream,
          initialData: bloc.historyList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Center(
                child: const Text("Error occured"),
              );
            var data = snapshot.data;
            if (data == null)
              return Center(
                child: Text("There is no history",
                    style: Theme.of(context).textTheme.bodyText2),
              );
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentHistory = data[index];
                  return Card(
                    margin: const EdgeInsets.only(top: 1),
                    child: ListTile(
                      title: Text(currentHistory.dateOfSaving.substring(0, 10),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2),
                      trailing: Text(currentHistory.dateOfSaving.substring(11),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2),
                      onTap: () {
                        bloc.currentHistory = currentHistory;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryTrackList(currentHistory),
                          ),
                        );
                      },
                    ),
                  );
                });
          }),
    );
  }
}
