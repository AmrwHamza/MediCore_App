import '../../domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.id,
    required super.doctorId,
    required super.title,
    required super.body,
    required super.createdAt,
    required super.updatedAt,
    required super.isFav,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      isFav: json['fav'],
    );
  }

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

  ArticleEntity toEntity() {
    return ArticleEntity(
      id: id,
      doctorId: doctorId,
      title: title,
      body: body,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isFav: isFav,
    );
  }
}
