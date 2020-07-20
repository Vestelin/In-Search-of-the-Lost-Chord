import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/historyBloc.dart';
import 'package:in_search_of_the_lost_chord/models/tracksHistory.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/trackList.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HistoryBloc bloc = BlocProvider.of<HistoryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.add),
            onPressed: () => bloc.addHistory(),
          )
        ],
      ),
      body: StreamBuilder<List<TracksHistory>>(
          stream: bloc.stream,
          initialData: bloc.historyList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("Error occured"),
              );
            var data = snapshot.data;
            if (data == null)
              return Center(
                child: Text("There is no history"),
              );
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var currentHistory = data[index];
                  return Card(
                    child: ListTile(
                      title: Text(currentHistory.dateOfSaving.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18)),
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
