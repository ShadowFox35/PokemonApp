part of 'pokemons_info_bloc.dart';

class PokemonsInfoState {
}

class PokemonsInfoInitial extends PokemonsInfoState {
}
class PokemonsInfoLoading extends PokemonsInfoState {
}

class PokemonsInfoLoaded extends PokemonsInfoState {
 PokemonsInfoLoaded({required this.pokemonsInfoLoaded});

  final PokemonInfoModel pokemonsInfoLoaded;
}

class PokemonsInfoFailure extends PokemonsInfoState {
  PokemonsInfoFailure({required this.failure});
  
  final Object? failure;
}
