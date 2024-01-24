import 'package:flutter/material.dart';
import 'package:meaning_farm/models/line.dart';

class ScreenOfLine extends StatefulWidget {
  ScreenOfLine({super.key, required this.line});

  final Line line;

  @override
  State<ScreenOfLine> createState() => _ScreenOfLineState();
}

class _ScreenOfLineState extends State<ScreenOfLine> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.line.words.split;
    print("words $words");
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox.square(dimension: 30),
                Text(widget.line.original),
                SizedBox.square(dimension: 20),
                Text(widget.line.transliteration),
                SizedBox.square(dimension: 20),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      final word = words[index];
                      return Column(children: [
                        SizedBox.square(dimension: 20),
                        Row(children: [
                          Flexible(child: Text(word.text.word)),
                          SizedBox.square(dimension: 20),
                          Flexible(child: Text(word.cuneiform.word)),
                          SizedBox.square(dimension: 20),
                          Flexible(child: Text(word.pos)),
                          SizedBox.square(dimension: 20),
                          Flexible(child: Text(word.label)),
                        ])
                      ]);
                    })
              ],
            )));
  }
}
