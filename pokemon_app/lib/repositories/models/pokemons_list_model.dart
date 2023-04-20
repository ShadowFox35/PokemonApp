class PokemonListModel {
  final String name;
  final String url;

  PokemonListModel({required this.name, required this.url});

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonRequestModel {
  int count;
  String? next;
  String? previous;
  List<PokemonListModel> results;

  PokemonRequestModel(
      {required this.count, this.next, this.previous, required this.results});

  factory PokemonRequestModel.fromJson(Map<String, dynamic> json) {
    return PokemonRequestModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((pokemonJson) => PokemonListModel.fromJson(pokemonJson))
          .toList(),
    );
  }
}