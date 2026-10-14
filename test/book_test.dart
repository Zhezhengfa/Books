import 'package:async_json/book.dart';
import 'package:test/test.dart';

void main() {
  group('Book.fromJson / toJson', () {
    test('正常数据可往返（roundtrip）', () {
      final json = {
        'id': 1,
        'title': '三体',
        'category': '科幻',
        'borrowCount': 256,
      };
      final book = Book.fromJson(json);
      expect(book.toJson(), equals(json));
    });

    test('缺失 borrowCount 默认为 0', () {
      final book = Book.fromJson({
        'id': 2,
        'title': '活着',
        'category': '文学',
      });
      expect(book.borrowCount, equals(0));
    });

    test('缺失字符串字段使用默认值', () {
      final book = Book.fromJson({
        'id': 3,
        'borrowCount': 10,
      });
      expect(book.title, equals('未命名'));
      expect(book.category, equals('未分类'));
    });

    test('类型错误时抛出 BookException', () {
      expect(
        () => Book.fromJson({
          'id': 4,
          'title': '错误书',
          'category': '测试',
          'borrowCount': '不是数字', 
        }),
        throwsA(isA<BookException>()),
      );
    });
  });
}