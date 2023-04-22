import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/pokemons_rep_export.dart';

part 'pokemons_info_state.dart';
part 'pokemons_info_event.dart';

class PokemonsInfoBloc extends Bloc<PokemonsInfoEvent, PokemonsInfoState> {
  PokemonsInfoBloc(this.pokemonsInfoRep) : super(PokemonsInfoInitial()) {
    on<LoadPokemonsInfo>((
      event,
      emit,
    ) async {
      try {
        final infoLoaded =
          await pokemonsInfoRep.getPokemonsInfo(event.name);
          emit (PokemonsInfoLoaded(pokemonsInfoLoaded: infoLoaded));
      } catch (error) {
        emit (PokemonsInfoFailure(failure: error));
      }
    });
  }
  final AbstractPokemonsInfoRep pokemonsInfoRep;
}


