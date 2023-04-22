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
