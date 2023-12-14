part of 'category_list_block.dart';

class CategoryListEvent {}

class ChildrenLoad extends CategoryListEvent {
  ChildrenLoad({required this.history});

  List<Categoty> history = [];

  Categoty? selected() {
    if (history.isEmpty) return null;
    return history.last;
  }
}
