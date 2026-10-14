import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';
import 'package:path/path.dart' as p;

Future<void> main() async {
  print('=== 图书借阅统计 ===\n');

  final dataFile = File(p.join('data', 'books.json'));

  String content;
  try {
    content = await dataFile.readAsString();
  } on FileSystemException catch (e) {
    print('❌ 文件读取失败：${e.message}');
    print('   路径：${e.path}');
    return;
  }

  List<dynamic> jsonList;
  try {
    jsonList = jsonDecode(content) as List<dynamic>;
  } on FormatException catch (e) {
    print('❌ JSON 格式错误：${e.message}');
    return;
  }

  final books = <Book>[];
  for (var i = 0; i < jsonList.length; i++) {
    try {
      books.add(Book.fromJson(jsonList[i] as Map<String, dynamic>));
    } on BookException catch (e) {
      print('⚠️  跳过第 ${i + 1} 条数据：$e');
    }
  }

  if (books.isEmpty) {
    print('没有可统计的图书数据。');
    return;
  }

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