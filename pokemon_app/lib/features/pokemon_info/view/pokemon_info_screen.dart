import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/repositories/pokemons_rep_export.dart';

import '../bloc/pokemons_info_bloc.dart';

class PokemonInfo extends StatefulWidget {
  final String? name;
  const PokemonInfo({this.name, Key? key}) : super(key: key);

  @override
  State<PokemonInfo> createState() => _InfoState();
}

class _InfoState extends State<PokemonInfo> {
  PokemonInfoModel? pokemonInfo;

  final _pokemonsInfoBloc =
      PokemonsInfoBloc(GetIt.I<AbstractPokemonsInfoRep>());

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _pokemonsInfoBloc.add(LoadPokemonsInfo(widget.name!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.name!,
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: BlocBuilder<PokemonsInfoBloc, PokemonsInfoState>(
          bloc: _pokemonsInfoBloc,
          builder: (context, state) {
            if (state is PokemonsInfoLoaded) {
              return bodyWidget(context, state);
            }
            if (state is PokemonsInfoFailure) {
              return Center(
                child: Text(
                  'Failed to get data. Please, check your internet connection.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            return loaderWidget(context);
          },
        )
        );
  }

  loaderWidget(BuildContext context) =>
      const Center(child: CircularProgressIndicator());

  bodyWidget(BuildContext context, state) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 30,
            left: 15.0,
            top: MediaQuery.of(context).size.height * 0.1,
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
                                image: NetworkImage(
                                    state.pokemonsInfoLoaded.img))),
                      )),
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
          ),
        ],
      );
}
