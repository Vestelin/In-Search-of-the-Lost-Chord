import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/release.dart';
import 'package:in_search_of_the_lost_chord/widgets/inherited/searchProvider.dart';
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



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(),
          FutureBuilder(
              future: SearchProvider.of(context).manager.findRelease(),
              builder: (context,
                  snapshot) {
                Widget result;
                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                  List<Release> foundReleases = snapshot.data;
                  var listView = getListViewOfFoundReleases(foundReleases);
                  result = SizedBox(child: listView, height: 300,);
                } else if (snapshot.hasError) {
                  result = getCenteredErrorText();
                } else {
                  result = CircularProgressIndicator();
                }
                return result;
              })
        ],
      ),
    );
  }
}
