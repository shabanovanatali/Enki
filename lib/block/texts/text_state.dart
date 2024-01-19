part of 'text_block.dart';

class TextState {
  bool isInit = true;
  final List<Lines> lines;

  TextState({
    this.lines = const [],
  });
}

class Lines {
  Lines({
    //required this.line,
    //required this.number,
    required this.transliteration,
    required this.original,
  });

  factory Lines.from(dynamic result) {
    return Lines(
      // line: result['line'],
      // number: result['number'],
      original: result["original"] ?? '',
      transliteration: result["transliteration"] ?? '',
    );
  }

  final String original;
  final String transliteration;
  // final String number;
}
