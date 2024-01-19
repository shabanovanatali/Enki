import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meaning_farm/blocs/categories/category_list_bloc.dart';
import 'package:meaning_farm/blocs/texts/text_bloc.dart';

class ScreenOfText extends StatefulWidget {
  ScreenOfText({super.key, required this.text});

  final Texts text;

  @override
  State<ScreenOfText> createState() => _ScreenOfTextState();
}

class _ScreenOfTextState extends State<ScreenOfText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            BackButton(onPressed: () {
              Navigator.pop(context);
            })
          ],
          leading: Image.asset(
            'assets/images/icon.png',
            fit: BoxFit.fill,
          ),
          title: Text(widget.text.label),
        ),
        body: BlocProvider(
            create: (context) => TextBloc(),
            child: BlocBuilder<TextBloc, TextState>(builder: (context, state) {
              if (state.isInit) {
                context
                    .read<TextBloc>()
                    .add(TextLinesRequest(text: widget.text));
                return Text("loading");
              } else {
                return SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(children: <Widget>[
                      transliteration(context, state),
                      original(context, state)
                    ]));
              }
            })));
  }
}

Widget transliteration(BuildContext context, TextState state) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: state.lines.length,
    itemBuilder: (BuildContext context, int index) {
      final item = state.lines[index];
      return TextButton(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          SizedBox.square(dimension: 1),
          // Icon(Icons.subject),
          Flexible(child: Text(item.transliteration)),
        ]),
        onPressed: () {},
      );
    },
  );
}

Widget original(BuildContext context, TextState state) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: state.lines.length,
    itemBuilder: (BuildContext context, int index) {
      final item = state.lines[index];
      return TextButton(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          SizedBox.square(dimension: 1),
          // Icon(Icons.subject),
          Flexible(child: Text(item.original)),
        ]),
        onPressed: () {},
      );
    },
  );
}
