import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/features/pokemon_info/pokemon_details_export.dart';
import 'package:pokemon_app/repositories/models/pokemons_list_model.dart';
import 'package:pokemon_app/repositories/pokemons_list_rep.dart';

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
  static const itemsPerPage = 10;
  @override
  void initState() {
    super.initState();
    _fetchPokemonList(0);
  }

  void _fetchPokemonList(offset) async {
    final PokemonRequestModel fetchedPokemonList =
        await PokemonsListRep().getPokemonsList(offset);

    setState(() {
      pokemonList = fetchedPokemonList.results;
      if (fetchedPokemonList.count != pokemonCount) {
        pokemonCount = fetchedPokemonList.count;
      }
    });
  }

  void _loadNextPage() {
    int nextPage = page + 1;
    if (nextPage < (pokemonCount / itemsPerPage).ceil()) {
      _fetchPokemonList(nextPage * itemsPerPage);
      setState(() {
        page = nextPage;
      });
    }
  }

  void _loadPreviousPage() {
    int previousPage = page - 1;
    if (previousPage >= 0) {
      _fetchPokemonList(previousPage * itemsPerPage);
      setState(() {
        page = previousPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pagesAmount = (pokemonCount / itemsPerPage).ceil();

    if (pokemonList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(children: [
        Expanded(
            child: PageView.builder(
          itemBuilder: (context, pageIndex) {
            return Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 300,
                    height: 500,
                    child: ListView.builder(
                      itemCount: itemsPerPage,
                      itemBuilder: (context, index) {
                        final pokemon =
                            pokemonList[index + pageIndex * itemsPerPage];
                        return SizedBox(
                            height: 40,
                            child: ListTile(
                              title: SizedBox(
                                  height: 50,
                                  child: Text(pokemon.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)),
                              onTap: () {
                                _fetchPokemonList(pageIndex + itemsPerPage);
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
                    )));
          },
          itemCount: pagesAmount,
        )),
        PaginationButtons(
          onNextPressed: _loadNextPage, //  callback для кнопки "Next"
          onPreviousPressed:
              _loadPreviousPage, //  callback для кнопки "Previous"
        ),
      ]);
    }
  }
}

class PaginationButtons extends StatelessWidget {
  final VoidCallback? onNextPressed;
  final VoidCallback? onPreviousPressed;

  const PaginationButtons({
    super.key,
    this.onNextPressed,
    this.onPreviousPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPreviousPressed,
          child: SvgPicture.asset(
            'assets/icons/prev.svg',
            width: 50,
            height: 50,
          ),
        ),
        GestureDetector(
          onTap: onNextPressed,
          child: SvgPicture.asset(
            'assets/icons/next.svg',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
