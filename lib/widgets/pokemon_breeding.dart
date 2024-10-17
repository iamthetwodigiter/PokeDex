import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/richtext_helper_function.dart';

class PokemonBreeding extends StatelessWidget {
  final Color pokemonColor;
  final Pokemon pokemon;
  const PokemonBreeding({
    super.key,
    required this.pokemonColor,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final breeding = pokemon.breeding;
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
                'Breeding',
                style: TextStyle(color: pokemonColor),
              ),
            ),
            SizedBox(
              height: 175,
              child: ListView.builder(
                itemCount: breeding.length,
                itemBuilder: (context, index) {
                  final field = breeding.keys.elementAt(index);
                  final value = breeding.values.elementAt(index);
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
