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

class PokemonInfoModel {
  String name;
  String img;
  int weight;
  int height;
  List<String> types;

  PokemonInfoModel({
    required this.name,
    required this.img,
    required this.weight,
    required this.height,
    required this.types,
  });

  factory PokemonInfoModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> typesJson = json['types'];
    List<String> typesList = typesJson
        .map((typeJson) => typeJson['type']['name'].toString())
        .toList();
    return PokemonInfoModel(
      name: json['name'],
      img: json['sprites']['front_default'],
      weight: json['weight'],
      height: json['height'],
      types: typesList,
    );
  }
}
