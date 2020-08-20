class StringUtils {
  static String insertCharAtIndex(String destinatedString, String character, {int index: 0}) {
    return destinatedString.replaceRange(index, index, character);
  }

}