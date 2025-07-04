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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isFav: json['fav'],
    );
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
