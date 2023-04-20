import 'package:flutter/material.dart';
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
                    // index - номер покемона на странице
                    itemBuilder: (context, index) {
                      final pokemon =
                          pokemonList[index + pageIndex * itemsPerPage];
                      return SizedBox(
                          height: 40,
                          child: ListTile(
                            title: SizedBox(
                                height: 50,
                                child: Text('${pokemon.name} ${pokemon.url}')),
                            onTap: () {
                              _fetchPokemonList(pageIndex + itemsPerPage);
                              Navigator.of(context).pushNamed('/pokemon_info');
                            },
                          ));
                    },
                  )));
        },
        itemCount: pagesAmount,
      )),
      PaginationButtons(
        onNextPressed:
            _loadNextPage, // Передача callback функции для кнопки "Next"
        onPreviousPressed:
            _loadPreviousPage, // Передача callback функции для кнопки "Previous"
      ),
    ]);
  }
}

class PaginationButtons extends StatelessWidget {
  final VoidCallback? onNextPressed;
  final VoidCallback? onPreviousPressed;

  PaginationButtons({this.onNextPressed, this.onPreviousPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPreviousPressed,
          child: Text('Previous'),
        ),
        ElevatedButton(
          onPressed: onNextPressed,
          child: Text('Next'),
        ),
      ],
    );
  }
}
