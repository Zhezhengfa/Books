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
  factory Book.fromJson(Map<String, dynamic> j) => Book(
        id: j['id'] as int,
        title: j['title'] as String,
        category: j['category'] as String,
        borrowCount: (j['borrowCount'] as num).toInt(),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'borrowCount': borrowCount,
      };
}