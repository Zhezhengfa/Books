import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';
import 'package:path/path.dart' as p;
void main() {

  final dataFile = File(p.join('data', 'books.json'));

  dataFile.readAsString().then((content) {

    final jsonList = jsonDecode(content) as List<dynamic>;

    final firstBook = Book.fromJson(jsonList.first as Map<String, dynamic>);
    print('第一本书：${firstBook.title}（${firstBook.category}），借阅 ${firstBook.borrowCount} 次');
  }).catchError((e) {
    print('出错了：$e');
  });
}