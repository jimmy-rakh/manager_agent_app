// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catigories_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<CategoriesDto> {
  @override
  final int typeId = 1;

  @override
  CategoriesDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesDto(
      id: fields[0] as int?,
      name: fields[1] as String?,
      imageUrl: fields[2] as String?,
      subCategories: (fields[3] as List?)?.cast<CategoriesDto>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.subCategories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
