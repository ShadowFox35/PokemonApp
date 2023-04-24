// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonInfoModelAdapter extends TypeAdapter<PokemonInfoModel> {
  @override
  final int typeId = 2;

  @override
  PokemonInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonInfoModel(
      name: fields[0] as String,
      img: fields[1] as String,
      weight: fields[2] as int,
      height: fields[3] as int,
      types: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonInfoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.img)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
