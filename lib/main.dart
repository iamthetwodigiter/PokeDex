import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/views/landing_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LandingPage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Pokemon',
        textTheme: const TextTheme(
          displayLarge: TextStyle(letterSpacing: 1.75, fontSize: 18),
          displayMedium: TextStyle(letterSpacing: 1.75, fontSize: 18),
          displaySmall: TextStyle(letterSpacing: 1.75, fontSize: 18),
          headlineLarge: TextStyle(letterSpacing: 1.75, fontSize: 18),
          headlineMedium: TextStyle(letterSpacing: 1.75, fontSize: 18),
          headlineSmall: TextStyle(letterSpacing: 1.75, fontSize: 18),
          titleLarge: TextStyle(letterSpacing: 1.75, fontSize: 18),
          titleMedium: TextStyle(letterSpacing: 1.75, fontSize: 18),
          titleSmall: TextStyle(letterSpacing: 1.75, fontSize: 18),
          bodyLarge: TextStyle(letterSpacing: 1.75, fontSize: 18),
          bodyMedium: TextStyle(letterSpacing: 1.75, fontSize: 18),
          bodySmall: TextStyle(letterSpacing: 1.75, fontSize: 18),
          labelLarge: TextStyle(letterSpacing: 1.75, fontSize: 18),
          labelMedium: TextStyle(letterSpacing: 1.75, fontSize: 18),
          labelSmall: TextStyle(letterSpacing: 1.75, fontSize: 18),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
