import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart' show rootBundle;

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListState()) {
    final load = () async {
      return await rootBundle
          .loadString("assets/categories.json")
          .then((jsonStr) => jsonDecode(jsonStr));
    };

    on<ChildrenLoad>((event, emit) async {
      final json = await load();

      List<String> titles = [];

      if (event.selected() == null) {
        print("selected == null");
        for (var item in json) {
          titles.add(item['label']);
        }
      } else {
        for (var item in json) {
          if (item['label'] == event.selected()) {
            final children = item['children'];
            for (var item in children) {
              titles.add(item['label']);
            }
            break;
          }
        }
      }

      var state = CategoryListState();
      state.isInit = false;
      state.titleList = titles;
      state.history = event.history;
      emit(state);
    });
  }
}
