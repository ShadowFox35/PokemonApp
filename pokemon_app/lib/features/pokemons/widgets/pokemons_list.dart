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
  @override
  void initState() {
    super.initState();
    _fetchPokemonList();
  }

  void _fetchPokemonList() async {
    final List<PokemonListModel> fetchedPokemonList =
        await PokemonsListRep().getPokemonsList();

    setState(() {
      pokemonList = fetchedPokemonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    const itemsPerPage = 5;
    final pagesAmount = (pokemonList.length / itemsPerPage).ceil();

    return PageView.builder(
      itemBuilder: (context, pageIndex) {
        return Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 250,
                height: 250,
                child: ListView.builder(
                  itemCount: itemsPerPage,
                  // index - номер покемона на странице
                  itemBuilder: (context, index) {
                    final pokemon =
                        pokemonList[index + pageIndex * itemsPerPage];
                    return SizedBox(
                        height: 35,
                        child: ListTile(
                          title: SizedBox(
                              height: 25,
                              child: Text('${pokemon.name} ${pokemon.url}')),
                          onTap: () {
                            Navigator.of(context).pushNamed('/pokemon_info');
                          },
                        ));
                  },
                )));
      },
      itemCount: pagesAmount,
    );
  }
}
