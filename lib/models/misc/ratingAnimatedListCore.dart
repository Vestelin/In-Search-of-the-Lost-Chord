import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/dataManagement/database.dart';
import 'package:in_search_of_the_lost_chord/models/iNamed.dart';

class RatingAnimatedListCore<T extends INamed> {
  List<T> presentedList;
  Widget Function(T) getProperRatingWidget;
  bool _insertNewItemAsFirstElement;
  GlobalKey<AnimatedListState> _listKey;

  RatingAnimatedListCore(this.getProperRatingWidget, this._listKey,
      this.presentedList, this._insertNewItemAsFirstElement)
      : assert(getProperRatingWidget != null),
        assert(_listKey != null);

  AnimatedListState get listState => _listKey.currentState;
  GlobalKey get listKey => _listKey;

  void _addItemToBothLists(T ratingItem, {int index: 0}) {
    presentedList.insert(index, ratingItem);
    listState.insertItem(index);
  }

  void addItem(T ratingItem) {
    if (_insertNewItemAsFirstElement) {
      _addItemToBothLists(ratingItem);
    } else {
      _addItemToBothLists(ratingItem, index: presentedList.length);
    }
  }

  void remove(T ratingItem) {}

  Widget buildItem(int index, Animation animation) {
    var properRatingWidget = getProperRatingWidget(presentedList[index]);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
          .animate(animation),
      child: properRatingWidget,
    );
  }

  void removeItem(T item) {
    int index = presentedList.indexOf(item);
    AnimatedListRemovedItemBuilder bbuilder = (context, animation) {
      var properRatingWidget = getProperRatingWidget(presentedList[index]);
      return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 0), end: Offset(1, 0))
              .animate(animation),
          child: properRatingWidget);
    };
    listState.removeItem(index, bbuilder, duration: Duration());
    presentedList.removeAt(index);
  }
}
