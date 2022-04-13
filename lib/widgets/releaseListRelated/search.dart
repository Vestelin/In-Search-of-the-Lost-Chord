import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/bloc/blocProvider.dart';
import 'package:in_search_of_the_lost_chord/bloc/searchBloc.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/releaseListRelated/releaseTile.dart';

class Search extends StatefulWidget {
  const Search();
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search>
    with AutomaticKeepAliveClientMixin<Search> {
  SearchBloc bloc;

  Widget getListViewOfFoundReleases(List<Release> foundReleases) {
    return ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: foundReleases.length,
        itemBuilder: (context, index) =>
            ReleaseTile.noKey(foundReleases[index]));
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  bool get wantKeepAlive => true;

  Widget getCenteredErrorText() {
    return const Center(
        child: const Text("Sorry, something with searching went wrong"));
  }

  Widget getCenteredText(String text) {
    return Padding(
      child: Text(text),
      padding: const EdgeInsets.only(top: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text("In Search of the Lost Chord")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            onChanged: (text) => bloc.sinkReleasesByKeyword(text),
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(18),
            ),
          ),
          Expanded(
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
