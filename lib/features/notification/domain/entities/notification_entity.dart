class NotificationEntity {
  final String id;
  final String type;
  final String message;
  final DateTime? readAt;
  final DateTime createdAt;

  NotificationEntity({
    required this.id,
    required this.type,
    required this.message,
    required this.readAt,
    required this.createdAt,
  });

  bool get isRead => readAt != null;
}
