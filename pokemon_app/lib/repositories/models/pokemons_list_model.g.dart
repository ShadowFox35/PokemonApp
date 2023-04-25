// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonListModelAdapter extends TypeAdapter<PokemonListModel> {
  @override
  final int typeId = 3;

  @override
  PokemonListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonListModel(
      name: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PokemonRequestModelAdapter extends TypeAdapter<PokemonRequestModel> {
  @override
  final int typeId = 1;

  @override
  PokemonRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonRequestModel(
      count: fields[0] as int,
      results: (fields[1] as List).cast<PokemonListModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonRequestModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
