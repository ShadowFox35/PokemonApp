import 'models/models_export.dart';

abstract class AbstractPokemonsListRep {
  Future<PokemonRequestModel> getPokemonsList(offset);
}

abstract class AbstractPokemonsInfoRep {
  Future<PokemonInfoModel> getPokemonsInfo(name);
}
