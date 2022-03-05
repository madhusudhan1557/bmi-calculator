// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bf_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BfmodelAdapter extends TypeAdapter<Bfmodel> {
  @override
  final int typeId = 1;

  @override
  Bfmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bfmodel()
      ..bf = fields[1] as String
      ..createdDate = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Bfmodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.bf)
      ..writeByte(2)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BfmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
