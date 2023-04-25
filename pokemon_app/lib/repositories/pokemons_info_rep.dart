import 'package:dio/dio.dart';
import 'package:pokemon_app/main.dart';
import 'models/models_export.dart';
import 'abstract_pokemons_rep.dart';

class PokemonsInfoRep implements AbstractPokemonsInfoRep {
  PokemonsInfoRep({required this.dio});
  final Dio dio;

  final requestTime = 6;

  @override
  Future<PokemonInfoModel> getPokemonsInfo(name) async {
    try {
      final response = await dio
          .get('https://pokeapi.co/api/v2/pokemon/$name')
          .timeout(Duration(seconds: requestTime));

      final pokemonRequestModel = PokemonInfoModel.fromJson(response.data);
      pokemonBox.put(name, pokemonRequestModel);

      return pokemonRequestModel;
    } catch (error) {
      if (pokemonBox.containsKey(name)) {
        return pokemonBox.get(name);
      } else {
        throw Exception('Failed to get pokemons list: $error');
      }
    }
  }
}
