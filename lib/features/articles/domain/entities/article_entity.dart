class ArticleEntity {
  final int id;
  final int doctorId;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isFav;

  ArticleEntity({
    required this.id,
    required this.doctorId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.isFav,
  });

  static final RegExp _imageRegex = RegExp(r'\[(.*?)\]');

  List<String> get paragraphs {
    return body
        .split(_imageRegex)
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  List<String> get images {
    return _imageRegex.allMatches(body).map((e) => e.group(1)!).toList();
  }
}
