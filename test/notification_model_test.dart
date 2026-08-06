import 'package:flutter_test/flutter_test.dart';
import 'package:medicore_app/features/notification/data/models/notification_model.dart';

void main() {
  group('NotificationModel.fromJson', () {
    test('parses a Reverse notification with message in data', () {
      final json = {
        'id': '05f5e100-0000-0000-0000-000000000001',
        'type': 'App\\Notifications\\Reverse',
        'data': {'message': 'Your appointment has been confirmed'},
        'read_at': null,
        'created_at': '2026-08-02T10:00:00.000000Z',
      };

      final model = NotificationModel.fromJson(json);

      expect(model.id, '05f5e100-0000-0000-0000-000000000001');
      expect(model.type, 'App\\Notifications\\Reverse');
      expect(model.message, 'Your appointment has been confirmed');
      expect(model.isRead, isFalse);
      expect(model.createdAt.year, 2026);
    });

    test('falls back to msg key when message is absent', () {
      final json = {
        'id': 12,
        'type': 'App\\Notifications\\ReminderNotification',
        'data': {'msg': 'Reminder for tomorrow'},
        'read_at': '2026-08-03T10:00:00.000000Z',
        'created_at': '2026-08-02T10:00:00.000000Z',
      };

      final model = NotificationModel.fromJson(json);

      expect(model.message, 'Reminder for tomorrow');
      expect(model.isRead, isTrue);
      expect(model.id, '12');
    });

    test('returns empty message when data is missing', () {
      final json = {
        'id': 1,
        'type': 'App\\Notifications\\Reverse',
        'created_at': '2026-08-02T10:00:00.000000Z',
      };

      final model = NotificationModel.fromJson(json);

      expect(model.message, isEmpty);
      expect(model.readAt, isNull);
    });
  });
}
