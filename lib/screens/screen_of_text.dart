import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meaning_farm/blocs/categories/category_list_bloc.dart';
import 'package:meaning_farm/blocs/texts/text_bloc.dart';
import 'package:meaning_farm/screens/screen_of_line.dart';

class ScreenOfText extends StatelessWidget {
  ScreenOfText({super.key, required this.text});

  final Texts text;

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
        title: Text(text.label),
      ),
      body: BlocProvider(
        create: (context) => TextBloc(),
        child: ListOfText(text: text),
      ),
    );
  }
}

class ListOfText extends StatefulWidget {
  ListOfText({super.key, required this.text});

  final Texts text;

  @override
  State<ListOfText> createState() => _ListOfTextState();
}

class _ListOfTextState extends State<ListOfText> {
  final sc = ScrollController();

  @override
  void initState() {
    super.initState();
    sc.addListener(_loadMore);
  }

  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  void _loadMore() {
    print("load more? ${sc.position.pixels} ${sc.position.maxScrollExtent}");
    if (sc.position.pixels == sc.position.maxScrollExtent) {
      // print("load more...");
      context.read<TextBloc>().add(TextLinesRequest(text: widget.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextBloc, TextState>(builder: (context, state) {
      if (state.isInit) {
        context.read<TextBloc>().add(TextLinesRequest(text: widget.text));
        return Text("loading");
      } else {
        return transliteration(context, state);
      }
    });
  }

  Widget transliteration(BuildContext context, TextState state) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: sc,
      // shrinkWrap: true,
      itemCount: state.lines.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.lines[index];
        return TextButton(
          child: ListTile(
            leading: Text(item.number),
            title:
                //Column(children: [
                // Text(item.original),
                Text(item.transliteration),
            //]),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenOfLine(
                  line: item,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
