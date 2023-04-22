import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/repositories/pokemons_rep_export.dart';

class PokemonInfo extends StatefulWidget {
  final String? name;
  const PokemonInfo({this.name, Key? key}) : super(key: key);

  @override
  State<PokemonInfo> createState() => _InfoState();
}

class _InfoState extends State<PokemonInfo> {
  PokemonInfoModel? pokemonInfo;
  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _getPokemonInfo(widget.name!);
    }
  }

  Future<void> _getPokemonInfo(String name) async {
    try {
      final response =
          await GetIt.I<AbstractPokemonsInfoRep>().getPokemonsInfo(name);
      setState(() {
        pokemonInfo = response;
      });
    } catch (error) {
      // Обработать ошибку при выполнении запроса
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
      body: pokemonInfo == null ? loaderWidget(context) : bodyWidget(context),
    );
  }

  loaderWidget(BuildContext context) =>
      const Center(child: CircularProgressIndicator());

  bodyWidget(BuildContext context) => Stack(
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
                      tag: pokemonInfo!.img,
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(pokemonInfo!.img))),
                      )),
                  Text(
                    pokemonInfo!.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text("Height: ${pokemonInfo!.height}",
                      style: Theme.of(context).textTheme.bodySmall),
                  Text("Weight: ${pokemonInfo!.weight}",
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(
                    "Types: ${pokemonInfo!.types.join(', ')}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
