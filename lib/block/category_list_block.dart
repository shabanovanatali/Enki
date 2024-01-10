import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_feathersjs/flutter_feathersjs.dart';

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

      List<Categoty> categories = [];
      List<Texts> texts = [];

      final selected = event.selected();
      if (selected == null) {
        for (var item in json) {
          categories.add(Categoty.from(item));
        }
      } else {
        for (var item in json) {
          if (item['id'] == selected.id) {
            final children = item['children'];
            for (var item in children) {
              categories.add(Categoty.from(item));
            }
            break;
          }
        }

        // 4210["find","listv",{"listId":"sumerian.literature","$skip":0,"$limit":20,"$startsWith":{"link":"/sumerian/text/etcsl[c.2.2"}}]

        if (selected.groupId.endsWith("*")) {
          final suffix = selected.groupId.replaceAll("*", '');

          final con = FlutterFeathersjs();
          con.init(baseUrl: "https://data.meanings.farm");

          final result = await con.find(serviceName: "listv", query: {
            "listId": "sumerian.literature",
            "\$startsWith": {"link": "/sumerian/text/etcsl[" + suffix}
          });

          for (var item in result['data']) {
            texts.add(Texts.from(item));
          }
        }
      }

      var state = CategoryListState();
      state.isInit = false;
      state.categories = categories;
      state.history = event.history;
      state.texts = texts;

      emit(state);
    });
  }
}
