import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:meaning_farm/blocs/categories/category_list_bloc.dart';
import 'package:meaning_farm/models/line.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextLinesRequest, TextState> {
  TextBloc() : super(TextState()) {
    on<TextLinesRequest>((event, emit) async {
      final listId = event.text.id();

      List<Line> lines = [];

      final con = FlutterFeathersjs();
      con.init(baseUrl: "https://data.meanings.farm");

      final result =
          await con.find(serviceName: "textlist", query: {"listId": listId});

      for (var item in result['data']) {
        lines.add(Line.from(item));
      }

      final state = TextState(lines: lines);
      state.isInit = false;

      emit(state);
    });
  }
}
