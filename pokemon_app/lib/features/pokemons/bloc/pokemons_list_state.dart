part of 'pokemons_list_bloc.dart';

class PokemonsListState {
}

class PokemonsListInitial extends PokemonsListState {
}
class PokemonsListLoading extends PokemonsListState {
}

class PokemonsListLoaded extends PokemonsListState {
  PokemonsListLoaded({required this.pokemonsListLoaded});

  final PokemonRequestModel pokemonsListLoaded;
}

class PokemonsListFailure extends PokemonsListState {
  PokemonsListFailure({required this.failure});
  
  final Object? failure;
}