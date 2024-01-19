part of 'category_list_bloc.dart';

class CategoryListState {
  bool isInit = true;
  List<Category> categories = [];
  List<Texts> texts = [];

  List<Category> history = [];

  Category? selected() {
    if (history.isEmpty) return null;
    return history.last;
  }
}

class Category {
  Category({
    required this.id,
    required this.groupId,
    required this.label,
  });

  factory Category.from(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      groupId: json['groupId'] ?? '',
      label: json['label'] ?? '',
    );
  }

  final String id;
  final String groupId;
  final String label;
}

class Texts {
  Texts({required this.label, required this.link});

  factory Texts.from(Map<String, dynamic> data) {
    return Texts(label: data['eng'], link: data['link']);
  }

  final String label;
  final String link;

  String id() {
    print("link $link");
    return link.substring(15);
  }
}
