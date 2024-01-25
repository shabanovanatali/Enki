import 'package:flutter/material.dart';
import 'package:meaning_farm/models/line.dart';
import 'package:meaning_farm/models/prefix_and_suffix.dart';
import 'package:meaning_farm/screens/screen_of_vocablary.dart';

//import 'package:meaning_farm/screens/screen_of_vocablary.dart';

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
                        Card(
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Vocablary()));
                                },
                                child: Column(children: [
                                  ListTile(
                                    title: Text(word.cuneiform.word),
                                    subtitle: Text(word.text.word),
                                  ),
                                  PrefixAndSuffix(
                                    word: word,
                                  )
                                ])))
                      ]);
                    })
              ],
            )));

    // Padding(
    //     padding: EdgeInsets.all(16.0),
    //     child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Expanded(
    //               child: Card(
    //                   margin: EdgeInsetsDirectional.symmetric(),
    //                   child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: <Widget>[
    //                         Text(widget.line.original),
    //                         Text(widget.line.transliteration),
    //                         ListView.builder(
    //                             physics: NeverScrollableScrollPhysics(),
    //                             shrinkWrap: true,
    //                             itemCount: words.length,
    //                             itemBuilder: (context, index) {
    //                               final word = words[index];
    //                               return Column(
    //                                 children: [
    //                                   Flexible(
    //                                       child: Text(word.text.word)),
    //                                   Flexible(
    //                                       child: Text(
    //                                           word.cuneiform.word)),
    //                                   ListTile(
    //                                     title: Text('Prefixes:'),
    //                                     subtitle: Text('prefixes'),
    //                                   ),
    //                                   ListTile(
    //                                     title: Text('Suffixes:'),
    //                                     subtitle: Text('suffixes'),
    //                                   )
    //                                 ],
    //                               );
    //                             })
    //                       ])))
    //         ]))
  }
}
