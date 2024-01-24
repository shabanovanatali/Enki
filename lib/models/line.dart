import 'package:meaning_farm/models/split.dart';

class Line {
  Line({
    required this.transliteration,
    required this.original,
    required this.words,
  });

  factory Line.from(dynamic json) {
    print("Lines.from $json");
    return Line(
        original: json["original"] ?? '',
        transliteration: json["transliteration"] ?? '',
        words: Split.from(json['split']));
  }

  final String original;
  final String transliteration;
  final Split words;
}
