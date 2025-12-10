// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_area_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubAreaHiveAdapter extends TypeAdapter<SubAreaHive> {
  @override
  final int typeId = 4;

  @override
  SubAreaHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubAreaHive(
      subAreaId: fields[0] as int?,
      areaId: fields[1] as int?,
      regionalId: fields[2] as int?,
      siteId: fields[3] as String?,
      branchId: fields[4] as String?,
      companyId: fields[5] as String?,
      headOfficeId: fields[6] as String?,
      namaArea: fields[7] as String?,
      keterangan: fields[8] as String?,
      status: fields[9] as String?,
      createdBy: fields[10] as String?,
      createdDate: fields[11] as String?,
      modifiedBy: fields[12] as String?,
      modifiedDate: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubAreaHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.subAreaId)
      ..writeByte(1)
      ..write(obj.areaId)
      ..writeByte(2)
      ..write(obj.regionalId)
      ..writeByte(3)
      ..write(obj.siteId)
      ..writeByte(4)
      ..write(obj.branchId)
      ..writeByte(5)
      ..write(obj.companyId)
      ..writeByte(6)
      ..write(obj.headOfficeId)
      ..writeByte(7)
      ..write(obj.namaArea)
      ..writeByte(8)
      ..write(obj.keterangan)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.createdBy)
      ..writeByte(11)
      ..write(obj.createdDate)
      ..writeByte(12)
      ..write(obj.modifiedBy)
      ..writeByte(13)
      ..write(obj.modifiedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubAreaHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
