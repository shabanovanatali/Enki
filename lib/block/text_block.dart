import 'package:flutter_bloc/flutter_bloc.dart';
//import 'dart:convert';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBlock extends Bloc<TextEvent, TextState> {
  TextBlock() : super(TextState()) {
    on<TextEvent>((event, emit) async {
      List<Lines> lines = [];

      //final selected = event.selected();

      //if (selected!.id.isNotEmpty) {
      final con = FlutterFeathersjs();
      con.init(baseUrl: "https://data.meanings.farm");

      //["find","textlist",{"listId":"etcsl[c.0.1.2]","$limit":10,"$skip":0}]

      final result = await con.find(serviceName: "textlist", query: {
        "listId": "etcsl[c.0.1.2]",
        //"\$startsWith": {"link": "/sumerian/text/etcsl[]"}
      });
      print("$result");
      for (var item in result['data']) {
        print("item $item");
        lines.add(Lines.from(item));
      }
      print("lines $lines");

      final state = TextState(lines: lines);
      state.isInit = false;

      emit(state);
    });
  }
}
