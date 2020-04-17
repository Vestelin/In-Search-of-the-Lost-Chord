import 'track.dart';
import 'utils/stringUtils.dart';

class Release {
  static const int commaIndexPositionInRating = 1;
  String name;
  List<Track> tracks;
  bool isConcept;
  Duration duration;

  get ratingWithComma => StringUtils.insertCharAtIndex("rating", ',');
}