import 'package:flutter_bloc/flutter_bloc.dart';
//import 'dart:convert';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:meaning_farm/block/categories/category_list_block.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBlock extends Bloc<TextLinesRequest, TextState> {
  TextBlock() : super(TextState()) {
    on<TextLinesRequest>((event, emit) async {
      final listId = event.text.id();

      print("listId $listId");

      List<Lines> lines = [];
      // final TextId text;

      //final selected = event.selected();

      //if (selected!.id.isNotEmpty) {
      final con = FlutterFeathersjs();
      con.init(baseUrl: "https://data.meanings.farm");

      //["find","textlist",{"listId":"etcsl[c.0.1.2]","$limit":10,"$skip":0}]

      //  final id = text.link.substring(15);

      final result = await con.find(serviceName: "textlist", query: {
        "listId": listId
        //"etcsl[c.0.1.2]",
        //"\$startsWith": {"link": "/sumerian/text/etcsl[]"}
      });

      for (var item in result['data']) {
        print("item $item");
        lines.add(Lines.from(item));
      }

      final state = TextState(lines: lines);
      state.isInit = false;

      emit(state);
    });
  }
}
