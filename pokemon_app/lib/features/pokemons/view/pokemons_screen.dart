import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

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
          title: Text('Pokemons List',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: const Center(
            child: SizedBox(
          height: 500,
          child: PokemonsList(),
        )));
  }
}
