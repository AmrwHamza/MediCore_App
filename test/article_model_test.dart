import 'package:flutter_test/flutter_test.dart';
import 'package:medicore_app/features/articles/data/models/article_model.dart';

void main() {
  group('ArticleModel.fromJson', () {
    test('parses a favorite article with fav flag', () {
      final json = {
        'id': 7,
        'doctor_id': 3,
        'title': 'Healthy habits',
        'body': 'Some body text',
        'created_at': '2026-07-01T09:00:00.000000Z',
        'updated_at': '2026-07-01T09:00:00.000000Z',
        'fav': true,
      };

      final model = ArticleModel.fromJson(json);

      expect(model.id, 7);
      expect(model.doctorId, 3);
      expect(model.title, 'Healthy habits');
      expect(model.isFav, isTrue);
      expect(model.createdAt.year, 2026);
    });

    test('extracts images and paragraphs from body', () {
      final json = {
        'id': 1,
        'doctor_id': 1,
        'title': 'Title',
        'body': 'Intro [image1.jpg] middle [image2.jpg] end',
        'created_at': '2026-07-01T09:00:00.000000Z',
        'updated_at': '2026-07-01T09:00:00.000000Z',
        'fav': false,
      };

      final model = ArticleModel.fromJson(json);

      expect(model.images, ['image1.jpg', 'image2.jpg']);
      expect(model.paragraphs, ['Intro', 'middle', 'end']);
    });

    test('defaults createdAt when value is missing', () {
      final json = {
        'id': 1,
        'doctor_id': 1,
        'title': 'Title',
        'body': 'Body',
        'updated_at': '2026-07-01T09:00:00.000000Z',
        'fav': false,
      };

      final model = ArticleModel.fromJson(json);

      expect(model.createdAt, isNotNull);
    });
  });
}
