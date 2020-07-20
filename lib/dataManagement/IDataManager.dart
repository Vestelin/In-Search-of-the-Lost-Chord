import 'package:in_search_of_the_lost_chord/models/release.dart';

abstract class IDataManager<T> {
  void save(T data);
  Future load();
}
