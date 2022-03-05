// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BmimodelAdapter extends TypeAdapter<Bmimodel> {
  @override
  final int typeId = 0;

  @override
  Bmimodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bmimodel()
      ..bmi = fields[1] as String
      ..createdDate = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Bmimodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.bmi)
      ..writeByte(2)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BmimodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
