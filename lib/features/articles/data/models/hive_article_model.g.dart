// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveArticleModelAdapter extends TypeAdapter<HiveArticleModel> {
  @override
  final int typeId = 3;

  @override
  HiveArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveArticleModel(
      id: fields[0] as int,
      doctorId: fields[1] as int,
      title: fields[2] as String,
      body: fields[3] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      isFav: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveArticleModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.isFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
