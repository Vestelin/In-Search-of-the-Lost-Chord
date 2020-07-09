import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/lesser/releaseTile.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  Widget getListViewOfFoundReleases(List<Release> foundReleases) {
    return ListView.builder(
        itemCount: foundReleases.length,
        itemBuilder: (context, index) =>
            ReleaseTile.noKey(foundReleases[index]));
  }

  Widget getCenteredErrorText() {
    return Center(child: Text("Sorry, something with searching went wrong"));
  }

  Widget getCenteredText(String text) {
    return Container(height: 200, child: Center(child: Text(text)));
  }

  TextEditingController searchFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: searchFieldController, 
            onChanged: (text) => bloc.getReleasesByKeyword(text),
          ),
          StreamBuilder<List<Release>>(
            stream: bloc.searchStream,
            builder: (context, snapshot) {
              final releases = snapshot.data;
              
              if(releases == null)
                return Container();

              if(releases.isEmpty) {
                return getCenteredText("There're no such releases");
              }
              List<Release> foundReleases = snapshot.data;
              var listView = getListViewOfFoundReleases(foundReleases);
              return SizedBox(
                    child: listView,
                    height: 300);
            },
          )
          /* FutureBuilder(
              future: SearchProvider.of(context).manager.findRelease(searchFieldController.text),
              builder: (context, snapshot) {
                Widget result;
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  List<Release> foundReleases = snapshot.data;
                  var listView = getListViewOfFoundReleases(foundReleases);
                  result = SizedBox(
                    child: listView,
                    height: 300,
                  );
                } else if (snapshot.hasError) {
                  result = getCenteredErrorText();
                } else {
                  result = CircularProgressIndicator();
                }
                return result;
              }) */
        ],
      ),
    );
  }
}
