// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CafeModelAdapter extends TypeAdapter<CafeModel> {
  @override
  final int typeId = 0;

  @override
  CafeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CafeModel(
      id: fields[0] as int,
      cafeName: fields[1] as String,
      email: fields[2] as String,
      ownerName: fields[3] as String,
      phone: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CafeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cafeName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.ownerName)
      ..writeByte(4)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CafeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
