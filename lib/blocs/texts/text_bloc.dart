import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:meaning_farm/blocs/categories/category_list_bloc.dart';
import 'package:meaning_farm/models/line.dart';

part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextLinesRequest, TextState> {
  TextBloc() : super(TextState()) {
    on<TextLinesRequest>(_onFetched);
  }

  Future<void> _onFetched(
    TextLinesRequest event,
    Emitter<TextState> emit,
  ) async {
    if (state.hasReachedMax) return;

    final listId = event.text.id();

    List<Line> lines = List.from(state.lines);

    final con = FlutterFeathersjs();
    con.init(baseUrl: "https://data.meanings.farm");

    final result = await con.find(
        serviceName: "textlist",
        query: {"listId": listId, "\$limit": 25, "\$skip": lines.length});

    if (result['data'].length == 0) {
      final newState = TextState(lines: lines);
      newState.isInit = false;
      newState.hasReachedMax = true;

      emit(newState);
    } else {
      for (var item in result['data']) {
        lines.add(Line.from(item));
      }

      final newState = TextState(lines: lines);
      newState.isInit = false;

      emit(newState);
    }
  }
}
