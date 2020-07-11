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
        physics: NeverScrollableScrollPhysics(),
        itemCount: foundReleases.length,
        itemBuilder: (context, index) =>
            ReleaseTile.noKey(foundReleases[index]));
  }

  Widget getCenteredErrorText() {
    return Center(child: Text("Sorry, something with searching went wrong"));
  }

  Widget getCenteredText(String text) {
    return Padding(
      child: Text(text),
      padding: EdgeInsets.only(top: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchBloc>(context);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (text) => bloc.getReleasesByKeyword(text),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 18)),
          ),
          SizedBox(
            height: 500,
            child: StreamBuilder<List<Release>>(
              stream: bloc.searchStream,
              builder: (context, snapshot) {
                final releases = snapshot.data;

                if (releases == null) return Container();

                if (releases.isEmpty) {
                  return getCenteredText("There're no such releases");
                }
                List<Release> foundReleases = snapshot.data;
                var listView = getListViewOfFoundReleases(foundReleases);
                return listView;
              },
            ),
          )
        ],
      ),
    );
  }
}
