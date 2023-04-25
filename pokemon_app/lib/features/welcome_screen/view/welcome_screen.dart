import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pokemon_logo.png',
            width: 300,
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pushNamed('/pokemons');
            },
            child: SvgPicture.asset(
              'assets/icons/pokeball.svg',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'press the pokeball to start ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ));
  }
}
