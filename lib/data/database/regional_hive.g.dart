// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regional_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegionalHiveAdapter extends TypeAdapter<RegionalHive> {
  @override
  final int typeId = 3;

  @override
  RegionalHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegionalHive(
      regionalId: fields[0] as int?,
      siteId: fields[1] as String?,
      namaRegional: fields[2] as String?,
      status: fields[3] as String?,
      branchId: fields[4] as String?,
      companyId: fields[5] as String?,
      headOfficeId: fields[6] as String?,
      createdBy: fields[7] as String?,
      createdDate: fields[8] as String?,
      modifiedBy: fields[9] as String?,
      modifiedDate: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegionalHive obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.regionalId)
      ..writeByte(1)
      ..write(obj.siteId)
      ..writeByte(2)
      ..write(obj.namaRegional)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.branchId)
      ..writeByte(5)
      ..write(obj.companyId)
      ..writeByte(6)
      ..write(obj.headOfficeId)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.createdDate)
      ..writeByte(9)
      ..write(obj.modifiedBy)
      ..writeByte(10)
      ..write(obj.modifiedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionalHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
