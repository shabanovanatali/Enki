part of 'text_bloc.dart';

class TextState {
  bool isInit = true;
  bool hasReachedMax = false;
  final List<Line> lines;

  TextState({
    this.lines = const [],
  });
}
