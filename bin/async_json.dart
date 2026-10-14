import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  final dataFile = File(p.join('data', 'books.json'));
  final content = await dataFile.readAsString();
  final List<dynamic> jsonList = jsonDecode(content) as List<dynamic>;
  final books = jsonList
      .map((e) => Book.fromJson(e as Map<String, dynamic>))
      .toList();
  print('=== 图书借阅统计 ===');
  print('总图书数：${books.length}');
  final categoryCount = <String, int>{};
  for (final b in books) {
    categoryCount[b.category] = (categoryCount[b.category] ?? 0) + 1;
  }
  print('\n分类数量：');
  categoryCount.forEach((cat, count) {
    print('  $cat: $count 本');
  });
  books.sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
  print('\n借阅量 Top3：');
  for (var i = 0; i < 3 && i < books.length; i++) {
    print('  ${i + 1}. ${books[i].title} — ${books[i].borrowCount} 次');
  }
}