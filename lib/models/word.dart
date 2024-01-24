class Word {
  Word(
      {required this.pos,
      required this.label,
      required this.cuneiform,
      required this.text});

  factory Word.from(dynamic json) {
    print("Word $json");
    return Word(
      pos: json["pos"] ?? '',
      label: json["label"] ?? '',
      cuneiform: WordAndRoot.from(json['cuneiform']),
      text: WordAndRoot.from(json),
    );
  }

  final String pos;
  final String label;
  final WordAndRoot text;
  final WordAndRoot cuneiform;
}

class WordAndRoot {
  WordAndRoot({required this.root, required this.word});

  factory WordAndRoot.from(dynamic json) {
    print("WordAndRoot $json");
    return WordAndRoot(root: json["lemma"], word: json["text"]);
  }

  final String word;
  final String root;
}
