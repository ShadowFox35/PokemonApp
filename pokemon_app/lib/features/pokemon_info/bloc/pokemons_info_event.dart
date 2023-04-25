part of 'pokemons_info_bloc.dart';

class PokemonsInfoEvent {}

class LoadPokemonsInfo extends PokemonsInfoEvent {
  final String name;

  LoadPokemonsInfo(this.name);
}
