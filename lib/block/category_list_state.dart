part of 'category_list_block.dart';

class CategoryListState {
  bool isInit = true;
  List<Categoty> categories = [];
  List<Texts> texts = [];

  List<Categoty> history = [];

  Categoty? selected() {
    if (history.isEmpty) return null;
    return history.last;
  }
}

class Categoty {
  Categoty({
    required this.id,
    required this.groupId,
    required this.label,
  });

  factory Categoty.from(Map<String, dynamic> json) {
    return Categoty(
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
  Texts({required this.label, required this.id});

  factory Texts.from(Map<String, dynamic> data) {
    return Texts(label: data['eng'], id: data['_id']);
  }

  final String id;
  final String label;
}
