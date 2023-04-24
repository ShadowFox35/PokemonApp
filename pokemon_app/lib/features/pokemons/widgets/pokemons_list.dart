import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/features/pokemon_info/pokemon_info_export.dart';
import 'package:pokemon_app/features/pokemons/bloc/pokemons_list_bloc.dart';
import 'package:pokemon_app/features/pokemons/widgets/widgets.dart';
import 'package:pokemon_app/repositories/pokemons_rep_export.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({
    super.key,
  });

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  List<PokemonListModel> pokemonList = [];
  int pokemonCount = 0;
  int page = 0;
  bool isLoading = false;
  static const itemsPerPage = 10;

  final _pokemonsListBloc = PokemonsListBloc(
    GetIt.I<AbstractPokemonsListRep>(),
  );

  @override
  void initState() {
    super.initState();
    _pokemonsListBloc.add(LoadPokemonsList(0, []));
  }

  // Future<bool> _fetchPokemonList(offset, list) async {
  //   _pokemonsListBloc.add(LoadPokemonsList(offset, list));
  //   setState(() {});
  //   return true;
  // }

  void _loadNextPage(list, pokemonCount) {
    int nextPage = page + 1;
    if (nextPage < (list.length / itemsPerPage).ceil()) {
      setState(() {
        page = nextPage;
      });
    } else if (nextPage < (pokemonCount / itemsPerPage).ceil()) {
      setState(() {
        isLoading = true;
      });

      _pokemonsListBloc.add(LoadPokemonsList(nextPage * itemsPerPage, list));
      setState(() {
        page = nextPage;
        isLoading = false;
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
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
                              ));
                        },
                      ),
                    ),
                  );
                },
                itemCount: pagesAmount,
              ),
            ),
            PaginationButtons(
              onNextPressed: () => _loadNextPage(pokemonListInfo.results,
                  pokemonListInfo.count), //  callback для кнопки "Next"
              onPreviousPressed: _loadPreviousPage,
              pagesAmount: pagesAmount,
              currentPage: page + 1, //  callback для кнопки "Previous"
            ),
          ]);
        }
        if (state is PokemonsListFailure) {
          return Center(
            child: Text(
              'Failed to get pokemons list. Please, check your internet connection.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
