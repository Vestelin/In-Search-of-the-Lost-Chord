import 'package:flutter/cupertino.dart';
import 'package:in_search_of_the_lost_chord/models/ratingListWidgetRepresentation.dart';
import 'package:in_search_of_the_lost_chord/models/track.dart';

class RatingAnimatedListCore<T> {
  List<T> presentedList;  
  Function<Widget>(T) getProperRatingWidget;
  bool _insertNewItemAsFirstElement;
  GlobalKey<AnimatedListState> _key;

  AnimatedListState get listState => _key.currentState;

  void _addItemToBothLists(T ratingItem, {int index:0}) {
    presentedList.insert(index, ratingItem);
    listState.insertItem(index);
  }

  void addItem(T ratingItem) {
    if(!_insertNewItemAsFirstElement) {
      _addItemToBothLists(ratingItem);
    } else {
      _addItemToBothLists(ratingItem, index:presentedList.length);
    }
  }

  Widget _buildItem(T item, Animation animation) {
    var properRatingWidget = getProperRatingWidget(item);
    return SlideTransition(
      position: animation,
      child: properRatingWidget,
    );
  }
  void removeItem(T item, Animation animation) {
    AnimatedListRemovedItemBuilder builder = (context, animation) => _buildItem(item, animation);
    listState.removeItem(presentedList.indexOf(item), builder);
    presentedList.remove(item);
  }
}
