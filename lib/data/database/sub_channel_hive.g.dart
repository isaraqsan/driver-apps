// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_channel_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubChannelHiveAdapter extends TypeAdapter<SubChannelHive> {
  @override
  final int typeId = 6;

  @override
  SubChannelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubChannelHive(
      id: fields[0] as int?,
      subChannel: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubChannelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subChannel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubChannelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
