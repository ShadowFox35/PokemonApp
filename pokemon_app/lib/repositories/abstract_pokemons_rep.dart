import 'models/models_export.dart';

abstract class AbstractPokemonsListRep {
  Future<PokemonRequestModel> getPokemonsList(offset, oldList);
}

abstract class AbstractPokemonsInfoRep {
  Future<PokemonInfoModel> getPokemonsInfo(name);
}
