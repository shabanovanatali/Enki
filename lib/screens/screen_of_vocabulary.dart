import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meaning_farm/blocs/vocablary/vocabulary_bloc.dart';
import 'package:meaning_farm/models/word.dart';

class Vocablary extends StatefulWidget {
  Vocablary({super.key, required this.word});

  final Word word;

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
          title: Text(widget.word.text.word),
        ),
        body: Container(
            child: Column(children: [
          Text(widget.word.text.root),
          Text(widget.word.cuneiform.root),
          BlocProvider(
              create: (context) => VocablaryBloc(),
              child: BlocBuilder<VocablaryBloc, VocabularyState>(
                  builder: (context, state) {
                if (state.isInit) {
                  context
                      .read<VocablaryBloc>()
                      .add(VocablaryEvent(word: widget.word));
                  return Text("loading");
                } else {
                  return Column(
                    children: [
                      detalies(context, state),
                      meanings(context, state)
                    ],
                  );
                }
              }))
        ])));
  }
}

Widget detalies(BuildContext context, VocabularyState state) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: state.details.length,
    itemBuilder: (BuildContext context, int index) {
      final item = state.details[index];
      return Column(children: [
        Text(item.visual),
        Text(item.normalized),
      ]);
    },
  );
}

Widget meanings(BuildContext context, VocabularyState state) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.details.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.details[index];
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: item.meanings.length,
          itemBuilder: (BuildContext context, int index) {
            final meanings = item.meanings[index];
            return Column(
              children: [
                Text(meanings.lemma),
                Text(meanings.pos),
                ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                  final trans = meanings.trans[index];
                  return Column(children: [
                    Text(trans.eng_label),
                    Text(trans.rus_label),
                    Text(trans.count.toString()),
                    Text(trans.pc.toString()),
                  ]);
                })
              ],
            );
          },
        );
      });
}
