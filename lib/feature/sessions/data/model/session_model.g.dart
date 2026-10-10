// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionModelAdapter extends TypeAdapter<SessionModel> {
  @override
  final int typeId = 3;

  @override
  SessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionModel(
      id: fields[0] as int,
      roomId: fields[1] as int,
      roomName: fields[2] as String,
      hourlyRate: fields[3] as double,
      startTime: fields[4] as DateTime,
      endTime: fields[5] as DateTime?,
      durationMinutes: fields[6] as int?,
      playstationCost: fields[7] as double,
      productsCost: fields[8] as double,
      totalCost: fields[9] as double,
      status: fields[10] as String,
      createdAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SessionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.roomId)
      ..writeByte(2)
      ..write(obj.roomName)
      ..writeByte(3)
      ..write(obj.hourlyRate)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.durationMinutes)
      ..writeByte(7)
      ..write(obj.playstationCost)
      ..writeByte(8)
      ..write(obj.productsCost)
      ..writeByte(9)
      ..write(obj.totalCost)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
