import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:pokemon_app/features/messages/messages.dart';
import 'package:pokemon_app/repositories/pokemons_rep_export.dart';
import '../widgets/widgets.dart';
import '../bloc/pokemons_info_bloc.dart';

class PokemonInfo extends StatefulWidget {
  final String? name;
  const PokemonInfo({this.name, Key? key}) : super(key: key);

  @override
  State<PokemonInfo> createState() => _InfoState();
}

class _InfoState extends State<PokemonInfo> {
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
  void dispose() {
    super.dispose();
    _pokemonsInfoBloc.close();
  }

  void _reloadPage() {
    _pokemonsInfoBloc.add(LoadPokemonsInfo(widget.name!));
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
            return PokemonInfoContent(state: state);
          }
          if (state is PokemonsInfoFailure) {
            return ErrorMessage(onPressedTryAgain: _reloadPage);
          }
          return loaderWidget(context);
        },
      ),
    );
  }

  Widget loaderWidget(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
