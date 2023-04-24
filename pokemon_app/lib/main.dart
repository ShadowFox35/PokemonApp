import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_app/pokemon_app.dart';
import 'repositories/pokemons_rep_export.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractPokemonsListRep>(
      () => PokemonsListRep(dio: Dio()));
  GetIt.I.registerLazySingleton<AbstractPokemonsInfoRep>(
      () => PokemonsInfoRep(dio: Dio()));
  runApp(const PokemonApp());
}
