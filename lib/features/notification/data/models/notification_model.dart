import 'package:medicore_app/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.type,
    required super.message,
    required super.readAt,
    required super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      message: _extractMessage(json['data']),
      readAt: _parseDate(json['read_at']),
      createdAt:
          _parseDate(json['created_at']) ??
          _parseDate(json['time']) ??
          DateTime.now(),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is int) {
      if (value > 1000000000000) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return DateTime.fromMillisecondsSinceEpoch(value * 1000);
    }
    return DateTime.tryParse(value?.toString() ?? '');
  }

  static String _extractMessage(dynamic data) {
    if (data is Map) {
      final nested = data['data'];
      if (nested is Map) return _extractMessage(nested);
      for (final key in const ['message', 'msg', 'title', 'text']) {
        final value = data[key];
        if (value is String && value.isNotEmpty) return value;
      }
      return data.values
          .map((e) => e?.toString() ?? '')
          .where((e) => e.isNotEmpty)
          .join('\n');
    }
    return data?.toString() ?? '';
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      type: type,
      message: message,
      readAt: readAt,
      createdAt: createdAt,
    );
  }
}
