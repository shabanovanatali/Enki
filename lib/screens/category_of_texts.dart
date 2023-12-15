import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meaning_farm/block/category_list_block.dart';

class CategoryOfTexts extends StatefulWidget {
  const CategoryOfTexts({super.key});

  @override
  State<CategoryOfTexts> createState() => _CategoryOfTextsState();
}

class _CategoryOfTextsState extends State<CategoryOfTexts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/icon.png',
          fit: BoxFit.fill,
        ),
        title: Text(
          'Sumerian',
        ),
      ),
      body: BlocProvider(
        create: (context) => CategoryListBloc(),
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
            builder: (context, state) {
          print("state $state");
          if (state.isInit) {
            context.read<CategoryListBloc>().add(ChildrenLoad(history: []));
            return Text("loading");
          } else {
            return Column(children: [
              if (state.selected() != null) goback(context, state),
              list(context, state),
              texts(context, state),
            ]);
          }
        }),
      ),
    );
  }

  Widget goback(BuildContext context, CategoryListState state) {
    return ElevatedButton(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          SizedBox.square(dimension: 1),
          Icon(Icons.home),
        ]),
        onPressed: () {
          List<Categoty> newhistory = List.from(state.history, growable: true);
          newhistory.removeLast();
          context
              .read<CategoryListBloc>()
              .add(ChildrenLoad(history: newhistory));
        });
  }

  Widget list(BuildContext context, CategoryListState state) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.categories.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.categories[index];
        return ElevatedButton(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              SizedBox.square(dimension: 1),
              Icon(Icons.play_arrow),
              Text(item.label),
            ]),
            onPressed: () {
              List<Categoty> newhistory = [...state.history, item];
              context
                  .read<CategoryListBloc>()
                  .add(ChildrenLoad(history: newhistory));
            });
      },
    );
  }
}

Widget texts(BuildContext context, CategoryListState state) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: state.texts.length,
    itemBuilder: (BuildContext context, int index) {
      final item = state.texts[index];
      return ElevatedButton(
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            SizedBox.square(dimension: 1),
            //Icon(Icons.play_arrow),
            Text(item.label),
          ]),
          onPressed: () {});
    },
  );
}
