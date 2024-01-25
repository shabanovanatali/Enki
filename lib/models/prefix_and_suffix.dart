import 'package:flutter/material.dart';
import 'package:meaning_farm/models/line.dart';
import 'package:meaning_farm/models/word.dart';

class PrefixAndSuffix extends StatefulWidget {
  PrefixAndSuffix({super.key, required this.word});

  final Word word;

  @override
  State<PrefixAndSuffix> createState() => _PrefixAndSuffix();
}

class _PrefixAndSuffix extends State<PrefixAndSuffix> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.word.text;
    final parts = text.word.split(text.root);
    final cuneiform = widget.word.cuneiform;
    final partsOfcuneiform = cuneiform.word.split(cuneiform.root);

    List<String> prefixes = [];
    List<String> suffixes = [];

    if (parts.isEmpty) {
    } else if (parts.length == 1) {
      final str = parts[0];
      if (str.endsWith("-")) {
        for (final suffix in str.split("-")) {
          suffixes.add(suffix);
        }
      } else {
        for (final prefix in str.split("-")) {
          prefixes.add(prefix);
        }
      }
    } else {
      final before = parts[0];
      final after = parts[parts.length - 1];
      for (final prefix in before.split("-")) {
        prefixes.add(prefix);
      }
      for (final suffix in after.split('-')) {
        suffixes.add(suffix);
      }
    }

    print("parts $parts");
    print("prefixes $prefixes");
    print("suffixes $suffixes");
    print('partsOfcuneiform $partsOfcuneiform');

    return Column(children: [
      ListTile(title: Text('Prefixes:'), subtitle: Text('$prefixes')),
      ListTile(title: Text('Suffixes:'), subtitle: Text('$suffixes'))
    ]);
  }
}
