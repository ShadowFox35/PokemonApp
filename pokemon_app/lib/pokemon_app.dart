import 'package:flutter/material.dart';
import 'package:pokemon_app/features/pokemon_info/pokemon_info_export.dart';
import 'package:pokemon_app/router/router.dart';
import 'package:pokemon_app/theme/theme.dart';


class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/pokemon_info/') == true) {
          final String? name = settings.name?.replaceAll('/pokemon_info/', '');
          return MaterialPageRoute(
            builder: (context) => PokemonInfo(name: name),
          );
        }
        return null;
      },
    );
  }
}