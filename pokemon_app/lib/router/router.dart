import '../features/pokemons/pokemons_export.dart';
import '../features/welcome_screen/welcome_export.dart';

final routes = {
  '/': (context) => const WelcomeScreen(),
  '/pokemons': (context) => const Pokemons(),
};
