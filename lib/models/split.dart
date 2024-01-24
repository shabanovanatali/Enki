import 'package:meaning_farm/models/word.dart';

class Split {
  Split({required this.split});

  factory Split.from(dynamic json) {
    List<Word> split = [];

    for (final item in json) {
      print("item $item");

      final word = Word.from(item);
      split.add(word);
    }
    return Split(
      split: split,
    );
  }

  final List<Word> split;
}
