import 'package:hive/hive.dart';

part 'pokemon_info_model.g.dart';

@HiveType(typeId: 2)
class PokemonInfoModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String img;

  @HiveField(2)
  final int weight;

  @HiveField(3)
  final int height;

  @HiveField(4)
  final List<String> types;

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
