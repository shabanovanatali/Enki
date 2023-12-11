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
          if (state.isInit) {
            context.read<CategoryListBloc>().add(ChildrenLoad(history: []));
            return Text("loading");
          } else {
            return Column(children: [
              if (state.selected() != null) goback(context, state),
              list(context, state),
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
          List<String> newhistory = List.from(state.history, growable: true);
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
      itemCount: state.titleList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.titleList[index];
        return ElevatedButton(
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              SizedBox.square(dimension: 1),
              Icon(Icons.play_arrow),
              Text(item),
            ]),
            onPressed: () {
              List<String> newhistory = [...state.history, item];
              context
                  .read<CategoryListBloc>()
                  .add(ChildrenLoad(history: newhistory));
            });
      },
    );
  }
}
