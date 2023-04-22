import 'package:flutter/material.dart';

final theme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(248, 253, 253, 240),
    colorScheme: const ColorScheme.light()
        .copyWith(primary: const Color.fromRGBO(255, 214, 1, 1)),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white),
        bodyMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            color: Color.fromRGBO(20, 96, 177, 1),
            fontWeight: FontWeight.w700),
        bodySmall: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Color.fromRGBO(31, 104, 182, 1))));
