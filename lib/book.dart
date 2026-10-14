class BookException implements Exception {
  final String message;
  BookException(this.message);

  @override
  String toString() => 'BookException: $message';
}

class Book {
  final int id;
  final String title;
  final String category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    // id
    int id;
    if (json['id'] == null) {
      id = 0;
    } else if (json['id'] is int) {
      id = json['id'] as int;
    } else {
      throw BookException(
          'id 字段类型错误，期望 int，实际为 ${json['id'].runtimeType}');
    }

    String title;
    if (json['title'] == null) {
      title = '未命名';
    } else if (json['title'] is String) {
      title = json['title'] as String;
    } else {
      throw BookException(
          'title 字段类型错误，期望 String，实际为 ${json['title'].runtimeType}');
    }

    String category;
    if (json['category'] == null) {
      category = '未分类';
    } else if (json['category'] is String) {
      category = json['category'] as String;
    } else {
      throw BookException(
          'category 字段类型错误，期望 String，实际为 ${json['category'].runtimeType}');
    }
    int borrowCount;
    if (json['borrowCount'] == null) {
      borrowCount = 0;
    } else if (json['borrowCount'] is num) {
      borrowCount = (json['borrowCount'] as num).toInt();
    } else {
      throw BookException(
          'borrowCount 字段类型错误，期望 num，实际为 ${json['borrowCount'].runtimeType}');
    }

    return Book(
      id: id,
      title: title,
      category: category,
      borrowCount: borrowCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'borrowCount': borrowCount,
    };
  }
}