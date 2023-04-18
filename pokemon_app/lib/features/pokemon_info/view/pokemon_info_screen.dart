import 'package:flutter/material.dart';

class PokemonInfo extends StatefulWidget {
  const PokemonInfo({super.key});

  @override
  State<PokemonInfo> createState() => _InfoState();
}

class _InfoState extends State<PokemonInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons Info'),
      ),
    );
  }
}
