import 'package:dio/dio.dart';
import 'models/pokemons_list_model.dart';

class PokemonsListRep {
  Future<PokemonRequestModel> getPokemonsList(offset) async {
    try {
      final response = await Dio()
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
