import 'package:dio/dio.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/utils/sort_function.dart';
import 'models/models_export.dart';
import 'abstract_pokemons_rep.dart';

class PokemonsListRep implements AbstractPokemonsListRep {
  PokemonsListRep({required this.dio});
  final Dio dio;

  final requestTime = 6;

  @override
  Future<PokemonRequestModel> getPokemonsList(offset, oldlist) async {
    try {
      final response = await dio
          .get('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=10')
          .timeout(Duration(seconds: requestTime));

      final pokemonRequestModel = PokemonRequestModel.fromJson(response.data);
      pokemonRequestModel.results = [
        ...oldlist,
        ...pokemonRequestModel.results
      ];
      pokemonRequestModel.results =
          sortListByUrlNumber(pokemonRequestModel.results);

      pokemonBox.put('count', pokemonRequestModel.count);
      pokemonBox.put('results', pokemonRequestModel.results);
      return pokemonRequestModel;
    } catch (error) {
      if (!pokemonBox.containsKey('results') ||
          pokemonBox.get('results').length <= offset) {
        throw Exception('Failed to get pokemons list: $error');
      }
      List<dynamic> resultsDynamic = pokemonBox.get('results');
      List<PokemonListModel> results = resultsDynamic
          .map((pokemonJson) =>
              PokemonListModel(name: pokemonJson.name, url: pokemonJson.url))
          .toList();
      results = sortListByUrlNumber(results);
      return PokemonRequestModel(
          count: pokemonBox.get('count'), results: results);
    }
  }
}
