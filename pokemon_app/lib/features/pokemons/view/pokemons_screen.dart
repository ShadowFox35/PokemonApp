import 'package:flutter/material.dart';

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
      body: PageView.builder(
        itemBuilder: (context, pageIndex) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Page $pageIndex, Item $index'),
                onTap: () {
                  Navigator.of(context).pushNamed('/pokemon_info');
                },
              );
            },
          );
        },
        itemCount: 3,
      ),
    );
  }
}
