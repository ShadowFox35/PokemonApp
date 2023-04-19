// class PokemonsListModel {
//   const PokemonsListModel({required this.name});

//   final String name;
// }

class PokemonListModel {
  final String name;

  PokemonListModel({required this.name});

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(name: json['name']);
  }
}
