class ArticleEntity {
  final int id;
  final int doctorId;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFav;

  ArticleEntity({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.isFav,
  });
}
