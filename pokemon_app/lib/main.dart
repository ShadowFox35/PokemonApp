import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_app/pokemon_app.dart';
import 'repositories/pokemons_rep_export.dart';

late Box pokemonBox;

Future<void> main() async {
  await Hive.initFlutter();
  
  Hive.registerAdapter(PokemonRequestModelAdapter());
  Hive.registerAdapter(PokemonInfoModelAdapter());
  Hive.registerAdapter(PokemonListModelAdapter());
  pokemonBox = await Hive.openBox('pokemonBox');
  GetIt.I.registerLazySingleton<AbstractPokemonsListRep>(
      () => PokemonsListRep(dio: Dio()));
  GetIt.I.registerLazySingleton<AbstractPokemonsInfoRep>(
      () => PokemonsInfoRep(dio: Dio()));

  runApp(const PokemonApp());
}
