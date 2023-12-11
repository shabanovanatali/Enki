part of 'category_list_block.dart';

class CategoryListState {
  bool isInit = true;
  List<String> titleList = [];

  List<String> history = [];

  String? selected() {
    if (history.isEmpty) return null;
    return history.last;
  }
}
