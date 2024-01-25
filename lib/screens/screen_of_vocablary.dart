import 'package:flutter/material.dart';
import 'package:meaning_farm/models/word.dart';

class Vocablary extends StatefulWidget {
  Vocablary({super.key});

  @override
  State<Vocablary> createState() => _VocablaryState();
}

class _VocablaryState extends State<Vocablary> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsetsDirectional.symmetric(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('data'),
                          subtitle: Text('data'),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Card(
                    child: Text('Vocablary'),
                  ),
                ),
              ]),
        )));
  }
}
