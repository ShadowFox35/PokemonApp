import 'package:flutter/material.dart';
import '../bloc/pokemons_info_bloc.dart';

class PokemonInfoContent extends StatelessWidget {
  const PokemonInfoContent({
    super.key,
    required this.state,
  });

  final PokemonsInfoLoaded state;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 300,
      height: 500,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(),
            Hero(
              tag: state.pokemonsInfoLoaded.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(state.pokemonsInfoLoaded.img),
                  ),
                ),
              ),
            ),
            Text(
              state.pokemonsInfoLoaded.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text("Height: ${state.pokemonsInfoLoaded.height}",
                style: Theme.of(context).textTheme.bodySmall),
            Text("Weight: ${state.pokemonsInfoLoaded.weight}",
                style: Theme.of(context).textTheme.bodySmall),
            Text(
              "Types: ${state.pokemonsInfoLoaded.types.join(', ')}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ));
  }
}