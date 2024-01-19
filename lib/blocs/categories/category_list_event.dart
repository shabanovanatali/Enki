part of 'category_list_bloc.dart';

class CategoryListEvent {}

class ChildrenLoad extends CategoryListEvent {
  ChildrenLoad({required this.history});

  List<Category> history = [];

  Category? selected() {
    if (history.isEmpty) return null;
    return history.last;
  }
}
