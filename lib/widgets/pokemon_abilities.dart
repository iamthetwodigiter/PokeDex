import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/richtext_helper_function.dart';

class PokemonAbilities extends StatelessWidget {
  final Color pokemonColor;
  final Pokemon pokemon;

  const PokemonAbilities({
    super.key,
    required this.pokemonColor,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final abilities = pokemon.abilities;
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
                'Abilities',
                style: TextStyle(color: pokemonColor),
              ),
            ),
            SizedBox(
              height: 170,
              child: Scrollbar(
                thumbVisibility: false,
                child: ListView.builder(
                  itemCount: abilities.length,
                  itemBuilder: (context, index) {
                    final item = abilities[index];
                    return styledRichText(
                      '${item['name']}\n\t',
                      item['description'],
                      pokemonColor,
                      fontSize: 16,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
