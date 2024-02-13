import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feathersjs/flutter_feathersjs.dart';
import 'package:meaning_farm/models/details_of_vocabulary.dart';
import 'package:meaning_farm/models/word.dart';

part 'vocabulary_event.dart';
part 'vocabulary_state.dart';

class VocablaryBloc extends Bloc<VocablaryEvent, VocabularyState> {
  VocablaryBloc() : super(VocabularyState()) {
    on<VocablaryEvent>((event, emit) async {
      List<Details> details = [];
      List<Meaning> meanings = [];

      final con = FlutterFeathersjs();
      con.init(baseUrl: "https://data.meanings.farm");

      final result =
          await con.find(serviceName: "visual", query: {"visual": "𒌨𒊕"});

      print("result $result");

      for (var item in result['data']) {
        details.add(Details.from(item));
      }

      final state = VocabularyState(details: details);
      state.isInit = false;

      emit(state);
    });
  }
}
