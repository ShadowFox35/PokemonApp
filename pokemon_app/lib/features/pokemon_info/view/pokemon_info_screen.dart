import 'package:flutter/material.dart';
import 'package:pokemon_app/repositories/models/pokemons_list_model.dart';
import 'package:pokemon_app/repositories/pokemons_list_rep.dart';

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
      final response = await PokemonsInfoRep().getPokemonsInfo(name);
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
        title: Text(widget.name!),
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
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: ${pokemonInfo!.height}"),
                  Text("Weight: ${pokemonInfo!.weight}"),
                  Text(
                    "Types: ${pokemonInfo!.types.join(', ')}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
