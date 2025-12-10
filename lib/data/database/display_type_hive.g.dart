// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_type_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DisplayTypeHiveAdapter extends TypeAdapter<DisplayTypeHive> {
  @override
  final int typeId = 2;

  @override
  DisplayTypeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DisplayTypeHive(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DisplayTypeHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisplayTypeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
