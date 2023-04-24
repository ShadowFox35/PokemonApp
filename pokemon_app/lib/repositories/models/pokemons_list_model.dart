import 'package:hive/hive.dart';

part 'pokemons_list_model.g.dart';

@HiveType(typeId: 3)
class PokemonListModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  PokemonListModel({required this.name, required this.url});

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      name: json['name'],
      url: json['url'],
    );
  }
}

@HiveType(typeId: 1)
class PokemonRequestModel {
  @HiveField(0)
  int count;

  @HiveField(1)
  List<PokemonListModel> results;

  PokemonRequestModel(
      {required this.count, required this.results});

  factory PokemonRequestModel.fromJson(Map<String, dynamic> json) {
    return PokemonRequestModel(
      count: json['count'],
      results: (json['results'] as List<dynamic>)
          .map((pokemonJson) => PokemonListModel.fromJson(pokemonJson))
          .toList(),
    );
  }
}
