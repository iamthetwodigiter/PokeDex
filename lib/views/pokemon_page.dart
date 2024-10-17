import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/widgets/pokemon_details.dart';

class PokemonPage extends ConsumerStatefulWidget {
  final String pokemonName;
  const PokemonPage({
    super.key,
    required this.pokemonName,
  });

  @override
  ConsumerState<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends ConsumerState<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    final pokemonData = ref.watch(pokemonDataProvider(widget.pokemonName));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 35,
            letterSpacing: 2.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: pokemonData.when(
          data: (value) {
            if (value != null) {
              return PokemonDetails(
                pokemon: value,
              );
            }
            return const Center(
              child: Text(
                'Error loading Pokemon data\nTry refining your search',
              ),
            );
          },
          error: ((error, stackTrace) {
            return const Text('Error while fetching Pokemon Data');
          }),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
