import 'track.dart';
import 'utils/stringUtils.dart';

class Release {
  static const int commaIndexPositionInRating = 1;
  int artistId;
  String name;
  String type;
  List<Track> tracks;
  String country;
  bool isConcept;
  DateTime releaseYear;
  Duration duration;
  String rating;

  get ratingWithComma => StringUtils.insertCharAtIndex(rating, ',');
}