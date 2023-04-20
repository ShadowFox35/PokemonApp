import 'package:dio/dio.dart';
import 'models/pokemons_list_model.dart';

class PokemonsListRep {
  Future<List<PokemonListModel>> getPokemonsList() async {
    try {
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon');

      if (response.statusCode == 200) {
        List<dynamic> results = response.data['results'];
        List<PokemonListModel> pokemonsList =
            results.map((result) => PokemonListModel.fromJson(result)).toList();
        return pokemonsList;
      } else {
        throw Exception('Failed to get pokemons list');
      }
    } catch (error) {
      throw Exception('Failed to get pokemons list: $error');
    }
  }
}
