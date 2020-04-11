import 'package:flutter/material.dart';

class RatingAnimatedListCore<T> {
  List<T> presentedList;
  Widget Function(T) getProperRatingWidget;
  bool _insertNewItemAsFirstElement;
  GlobalKey<AnimatedListState> _key;

  RatingAnimatedListCore(this.getProperRatingWidget, this._key,
      this.presentedList, this._insertNewItemAsFirstElement)
      : assert(getProperRatingWidget != null),
        assert(_key != null);

  AnimatedListState get listState => _key.currentState;

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

  Widget buildItem(int index, Animation animation) {
    var properRatingWidget = getProperRatingWidget(presentedList[index]);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(animation),
      child: properRatingWidget,
    );
  }

  void removeItem(int index, Animation animation) {
    AnimatedListRemovedItemBuilder builder =
        (context, animation) => buildItem(index, animation);
    listState.removeItem(presentedList.indexOf(presentedList[index]), builder);
    presentedList.remove(presentedList[index]);
  }
}
