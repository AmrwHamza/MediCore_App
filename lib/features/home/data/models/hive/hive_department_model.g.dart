// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_department_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDepartmentModelAdapter extends TypeAdapter<HiveDepartmentModel> {
  @override
  final int typeId = 1;

  @override
  HiveDepartmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDepartmentModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      image: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDepartmentModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDepartmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
