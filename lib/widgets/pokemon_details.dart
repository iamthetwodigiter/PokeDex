import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/richtext_helper_function.dart';
import 'package:pokedex/utils/types_colors.dart';
import 'package:pokedex/widgets/pokemon_abilities.dart';
import 'package:pokedex/widgets/pokemon_breeding.dart';
import 'package:pokedex/widgets/pokemon_stats.dart';
import 'package:pokedex/widgets/pokemon_training.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetails({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  Color? paletteColor;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    getImagePalette();
  }

  void getImagePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.pokemon.image));
    setState(() {
      paletteColor = paletteGenerator.dominantColor?.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pokemon = widget.pokemon;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: paletteColor!.withAlpha(50),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: paletteColor!,
                      width: 2,
                    ),
                  ),
                  child: CachedNetworkImage(imageUrl: pokemon.image),
                ),
              ),
              Center(
                child: Text(
                  pokemon.name,
                  style: TextStyle(
                      color: paletteColor, fontSize: 35, letterSpacing: 5),
                ),
              ),
              Row(
                children: [
                  styledRichText('ID: ', pokemon.id.toString(), paletteColor!),
                  const Spacer(),
                  styledRichText('Generation: ', pokemon.generation.toString(),
                      paletteColor!),
                  const Spacer(),
                ],
              ),
              styledRichText('Species: ', pokemon.species, paletteColor!),
              styledRichText('Height: ', pokemon.height, paletteColor!),
              styledRichText('Weight: ', pokemon.weight, paletteColor!),
              styledRichText(
                  'Mega: ', pokemon.mega ? 'Yes' : 'No', paletteColor!),
              SizedBox(
                width: size.width,
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pokemon.types.length + 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? const Text(
                            'Types: ',
                            style: TextStyle(color: Colors.white),
                          )
                        : Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: typeColors[pokemon.types[index - 1]],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Text(
                                  pokemon.types[index - 1],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  pokemon.types[index - 1],
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? PokemonAbilities(
                            pokemonColor: paletteColor!,
                            pokemon: pokemon,
                          )
                        : index == 1
                            ? PokemonStats(
                                pokemonColor: Colors.pink,
                                pokemon: pokemon,
                              )
                            : index == 2
                                ? PokemonTraining(
                                    pokemonColor: Colors.blue,
                                    pokemon: pokemon,
                                  )
                                : PokemonBreeding(
                                    pokemonColor: Colors.greenAccent,
                                    pokemon: pokemon,
                                  );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
