part of 'pokemons_list_bloc.dart';

class PokemonsListEvent {}

class LoadPokemonsList extends PokemonsListEvent {
  final int offset;
  final List<PokemonListModel> list;
  LoadPokemonsList(this.offset, this.list);
}
