// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addwork_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkModelAdapter extends TypeAdapter<WorkModel> {
  @override
  final int typeId = 2;

  @override
  WorkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkModel(
      id: fields[0] as int?,
      worklist: fields[1] as String,
      stafflist: fields[2] as String,
      name: fields[3] as String,
      location: fields[4] as String,
      apartment: fields[5] as String,
      phonenumber: fields[6] as String,
      date: fields[7] as String,
      day: fields[8] as String,
      amount: fields[9] as String,
      workstatus: fields[10] as bool,
      paidstatus: fields[11] as bool,
      remarks: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.worklist)
      ..writeByte(2)
      ..write(obj.stafflist)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.apartment)
      ..writeByte(6)
      ..write(obj.phonenumber)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.day)
      ..writeByte(9)
      ..write(obj.amount)
      ..writeByte(10)
      ..write(obj.workstatus)
      ..writeByte(11)
      ..write(obj.paidstatus)
      ..writeByte(12)
      ..write(obj.remarks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
