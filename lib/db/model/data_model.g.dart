// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StaffModelAdapter extends TypeAdapter<StaffModel> {
  @override
  final int typeId = 1;

  @override
  StaffModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StaffModel(
      id: fields[1] as String,
      name: fields[2] as String,
      genter: fields[3] as String,
      address: fields[4] as String,
      phonenumber: fields[5] as String,
      salary: fields[6] as String,
      position: fields[7] as String,
      proimage: fields[8] as String,
      idimage: fields[9] as String?,
      idDB: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StaffModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idDB)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.genter)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.phonenumber)
      ..writeByte(6)
      ..write(obj.salary)
      ..writeByte(7)
      ..write(obj.position)
      ..writeByte(8)
      ..write(obj.proimage)
      ..writeByte(9)
      ..write(obj.idimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaffModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
