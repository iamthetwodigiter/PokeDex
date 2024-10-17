import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/richtext_helper_function.dart';

class PokemonStats extends StatelessWidget {
  final Color pokemonColor;
  final Pokemon pokemon;
  const PokemonStats({
    super.key,
    required this.pokemonColor,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final stats = pokemon.stats;
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Container(
        height: 225,
        width: size.width - 30,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: pokemonColor.withAlpha(50),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: pokemonColor,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Stats',
                style: TextStyle(color: pokemonColor),
              ),
            ),
            SizedBox(
              height: 175,
              
              child: ListView.builder(
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final field = stats.keys.elementAt(index).toUpperCase();
                  final value = stats.values.elementAt(index);
                  return styledRichText(
                    '$field: ',
                    value,
                    pokemonColor,
                    fontSize: 16,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
