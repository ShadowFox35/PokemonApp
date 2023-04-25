import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/features/pokemon_info/pokemon_info_export.dart';
import 'package:pokemon_app/features/pokemons/bloc/pokemons_list_bloc.dart';
import 'package:pokemon_app/features/pokemons/widgets/widgets.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/repositories/pokemons_rep_export.dart';
import 'package:pokemon_app/features/messages/messages.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({
    super.key,
  });

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  int page = 0;
  static const itemsPerPage = 10;

  final _pokemonsListBloc = PokemonsListBloc(
    GetIt.I<AbstractPokemonsListRep>(),
  );

  @override
  void initState() {
    super.initState();
    _pokemonsListBloc.add(LoadPokemonsList(0, []));
  }

  @override
  void dispose() {
    super.dispose();
    _pokemonsListBloc.close();
  }

  void _loadNextPage(list, pokemonCount) {
    int nextPage = page + 1;
    if (nextPage < (list.length / itemsPerPage).ceil()) {
      setState(() {
        page = nextPage;
      });
    } else if (nextPage < (pokemonCount / itemsPerPage).ceil()) {
      _pokemonsListBloc.add(LoadPokemonsList(nextPage * itemsPerPage, list));
      setState(() {
        page = nextPage;
      });
    }
  }

  void _loadPreviousPage() {
    int previousPage = page - 1;
    if (previousPage >= 0) {
      setState(() {
        page = previousPage;
      });
    }
  }

  void _reloadPage() {
    List<PokemonListModel> oldList = [];
    if (pokemonBox.get('results').length != 0) {
      oldList = pokemonBox.get('results');
    }
    _pokemonsListBloc.add(LoadPokemonsList(page * itemsPerPage, oldList));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsListBloc, PokemonsListState>(
      bloc: _pokemonsListBloc,
      builder: (context, state) {
        if (state is PokemonsListLoaded) {
          final pagesAmount =
              (state.pokemonsListLoaded.count / itemsPerPage).ceil();
          final pokemonListInfo = state.pokemonsListLoaded;
          return Column(children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, pageIndex) {
                  return Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300,
                      height: 500,
                      child: ListView.builder(
                        itemCount: itemsPerPage,
                        itemBuilder: (context, index) {
                          final pokemon = state.pokemonsListLoaded
                              .results[index + page * itemsPerPage];

                          return SizedBox(
                            height: 40,
                            child: ListTile(
                              title: Center(
                                child: Text(pokemon.name,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PokemonInfo(
                                      name: pokemon.name,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                itemCount: pagesAmount,
              ),
            ),
            PaginationButtons(
              onNextPressed: () =>
                  _loadNextPage(pokemonListInfo.results, pokemonListInfo.count),
              onPreviousPressed: _loadPreviousPage,
              pagesAmount: pagesAmount,
              currentPage: page + 1,
            ),
          ]);
        }
        if (state is PokemonsListFailure) {
          return ErrorMessage(onPressedTryAgain: _reloadPage);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
