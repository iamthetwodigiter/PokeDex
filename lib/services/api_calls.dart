import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon_model.dart';

Future<Pokemon?> fetchPokemonList(String pokemon) async {
  final response = await http
      .get(Uri.parse('https://ex.traction.one/pokedex/pokemon/$pokemon'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    try {
      final pokemonData = Pokemon.fromMap(data[0]);
     
      return Pokemon(
        id: pokemonData.id,
        name: pokemonData.name,
        generation: pokemonData.generation,
        species: pokemonData.species,
        types: pokemonData.types,
        abilities: pokemonData.abilities,
        height: pokemonData.height,
        weight: pokemonData.weight,
        mega: pokemonData.mega,
        stats: pokemonData.stats,
        training: pokemonData.training,
        breeding: pokemonData.breeding,
        image: pokemonData.image,
      );
    } catch (e) {
      rethrow;
    }
  }
  return null;
}
