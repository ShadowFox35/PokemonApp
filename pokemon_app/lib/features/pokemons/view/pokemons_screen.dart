import 'package:flutter/material.dart';
import '../widgets/pokemons_list.dart';

class Pokemons extends StatefulWidget {
  const Pokemons({super.key});

  @override
  State<Pokemons> createState() => _PokemonsState();
}


class _PokemonsState extends State<Pokemons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons List'),
        ),
        body: const Center(
            child: SizedBox(
          width: 300,
          height: 200,
          child: PokemonsList(),
        )));
  }
}
