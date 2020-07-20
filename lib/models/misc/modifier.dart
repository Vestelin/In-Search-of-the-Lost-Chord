enum Modifiers { bestPiano, bestVocal, bestGuitar, bestDrums }

enum TrackModifier {
  toReconsider,
}

class TrackModifierWrapper {
  TrackModifier modifier;
  bool isEnabled;

  TrackModifierWrapper({this.modifier, this.isEnabled: false});

  TrackModifierWrapper.fromJson(Map<String, dynamic> json) {
    int modifierIndex = json['modifier'];
    modifier = TrackModifier.values[modifierIndex];
    isEnabled = json['isEnabled'];
  }

  Map<String, dynamic> toJson() =>
      {'modifier': modifier.index, 'isEnabled': isEnabled};
}
