import 'package:dio/dio.dart';
import 'models/models_export.dart';
import 'abstract_pokemons_list_rep.dart';

class PokemonsListRep implements AbstractPokemonsListRep {
  PokemonsListRep({required this.dio});
  final Dio dio;

  @override
  Future<PokemonRequestModel> getPokemonsList(offset) async {
    try {
      final response = await dio
          .get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=10');

      if (response.statusCode == 200) {
        final pokemonRequestModel = PokemonRequestModel.fromJson(response.data);
        return pokemonRequestModel;
      } else {
        throw Exception('Failed to get pokemons list');
      }
    } catch (error) {
      throw Exception('Failed to get pokemons list: $error');
    }
  }
}

class PokemonsInfoRep implements AbstractPokemonsInfoRep {
  PokemonsInfoRep({required this.dio});
  final Dio dio;

  @override
  Future<PokemonInfoModel> getPokemonsInfo(name) async {
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');

      if (response.statusCode == 200) {
        final pokemonRequestModel = PokemonInfoModel.fromJson(response.data);
        return pokemonRequestModel;
      } else {
        throw Exception('Failed to get pokemon info');
      }
    } catch (error) {
      throw Exception('Failed to get pokemon info: $error');
    }
  }
}
