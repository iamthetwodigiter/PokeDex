import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/services/api_calls.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

final homeScreenDataProvider = FutureProvider<Map<String, String>>((ref) async {
  final String jsonString = await rootBundle.loadString('assets/pokemon_sprites.json');

  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  final Map<String, String> pokemonMap = {
    for (var entry in jsonData.entries)
      entry.key.toString(): entry.value as String
  };
  return pokemonMap;
});

final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, String pokemon) async {
  return fetchPokemonList(pokemon);
});
