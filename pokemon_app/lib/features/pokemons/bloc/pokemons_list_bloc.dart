import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/pokemons_rep_export.dart';

part 'pokemons_list_state.dart';
part 'pokemons_list_event.dart';

class PokemonsListBloc extends Bloc<PokemonsListEvent, PokemonsListState> {
  PokemonsListBloc(this.pokemonsListRep) : super(PokemonsListInitial()) {
    on<LoadPokemonsList>((
      event,
      emit,
    ) async {
      try {
        emit(PokemonsListLoading());

        final fetchedPokemonList =
            await pokemonsListRep.getPokemonsList(event.offset);
        fetchedPokemonList.results = [
          ...event.list,
          ...fetchedPokemonList.results
        ];

        emit(PokemonsListLoaded(pokemonsListLoaded: fetchedPokemonList));
      } on Exception catch (error) {
        emit(PokemonsListFailure(failure: error));
      }
    });
  }
  final AbstractPokemonsListRep pokemonsListRep;
}
