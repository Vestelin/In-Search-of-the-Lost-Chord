import 'package:flutter/material.dart';
import 'package:in_search_of_the_lost_chord/models/searchManager.dart';

class SearchProvider extends InheritedWidget {
  final SearchManager manager;

  SearchProvider(this.manager, {Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(SearchProvider oldWidget) {
    return manager != oldWidget.manager;
  }

  static SearchProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SearchProvider>();
  }
}