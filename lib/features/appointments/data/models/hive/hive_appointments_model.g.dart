// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_appointments_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAppointmentModelAdapter extends TypeAdapter<HiveAppointmentModel> {
  @override
  final int typeId = 0;

  @override
  HiveAppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAppointmentModel(
      id: fields[0] as int,
      patientId: fields[1] as int,
      doctorId: fields[2] as int,
      departmentId: fields[3] as int,
      appointmentDate: fields[4] as DateTime,
      appointmentStatus: fields[5] as String,
      status: fields[6] as String,
      enter: fields[7] as int,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAppointmentModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patientId)
      ..writeByte(2)
      ..write(obj.doctorId)
      ..writeByte(3)
      ..write(obj.departmentId)
      ..writeByte(4)
      ..write(obj.appointmentDate)
      ..writeByte(5)
      ..write(obj.appointmentStatus)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.enter)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
