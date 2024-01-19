import 'package:flutter_bloc/flutter_bloc.dart';

part 'line_event.dart';
part 'line_state.dart';

class LineBloc extends Bloc<LineEvent, LineState> {
  LineBloc() : super(LineState()) {
    on<LineEvent>(event, emit) {}
  }
}
