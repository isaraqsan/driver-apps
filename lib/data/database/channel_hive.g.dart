// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChannelHiveAdapter extends TypeAdapter<ChannelHive> {
  @override
  final int typeId = 5;

  @override
  ChannelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChannelHive(
      id: fields[0] as int?,
      channel: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChannelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.channel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
