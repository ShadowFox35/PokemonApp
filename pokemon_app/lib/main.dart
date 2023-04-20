import 'package:flutter/material.dart';
import 'package:pokemon_app/features/pokemon_info/pokemon_details_export.dart';
import 'package:pokemon_app/features/pokemons/pokemons_export.dart';
import 'package:pokemon_app/features/welcome_screen/welcome_export.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 216, 0.98),
          colorScheme: const ColorScheme.light()
              .copyWith(primary: const Color.fromRGBO(225, 238, 50, 1)),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(93, 156, 236, 1)),
              labelSmall: TextStyle(fontSize: 16))),
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/pokemons': (context) => const Pokemons(),
      },
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/pokemon_info/') == true) {
          final String? name = settings.name?.replaceAll('/pokemon_info/', '');
          return MaterialPageRoute(
            builder: (context) => PokemonInfo(name: name),
          );
        }
        return null;
      },
      // onUnknownRoute: (settings) {
      //   // Обработка неизвестного маршрута
      //   return MaterialPageRoute(builder: (context) => UnknownScreen());
      // },
    );
  }
}
