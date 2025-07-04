// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_doctor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDoctorModelAdapter extends TypeAdapter<HiveDoctorModel> {
  @override
  final int typeId = 2;

  @override
  HiveDoctorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDoctorModel(
      doctorId: fields[0] as int,
      departmentId: fields[1] as int,
      userId: fields[2] as int,
      bio: fields[3] as String,
      departmentName: fields[4] as String,
      departmentImage: fields[5] as String,
      doctorUserFirstName: fields[6] as String,
      doctorUserLastName: fields[7] as String,
      doctorUserImage: fields[8] as String,
      doctorUserEmail: fields[9] as String,
      doctorUserPhone: fields[10] as String,
      doctorUserExperience: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDoctorModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.doctorId)
      ..writeByte(1)
      ..write(obj.departmentId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.bio)
      ..writeByte(4)
      ..write(obj.departmentName)
      ..writeByte(5)
      ..write(obj.departmentImage)
      ..writeByte(6)
      ..write(obj.doctorUserFirstName)
      ..writeByte(7)
      ..write(obj.doctorUserLastName)
      ..writeByte(8)
      ..write(obj.doctorUserImage)
      ..writeByte(9)
      ..write(obj.doctorUserEmail)
      ..writeByte(10)
      ..write(obj.doctorUserPhone)
      ..writeByte(11)
      ..write(obj.doctorUserExperience);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDoctorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
