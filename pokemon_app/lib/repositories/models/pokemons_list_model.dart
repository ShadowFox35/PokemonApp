// class PokemonListModel {
//   final String name;

//   PokemonListModel({required this.name});

//   factory PokemonListModel.fromJson(Map<String, dynamic> json) {
//     return PokemonListModel(name: json['name']);
//   }
// }

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
