import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/views/pokemon_page.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final TextEditingController _searchController = TextEditingController();
  int startIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  void updateSection(int newStartIndex) {
    setState(() {
      startIndex = newStartIndex;
    });
  }

  Future<void> _onRefresh() async {
    ref.read(homeScreenDataProvider);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pokemonData = ref.watch(homeScreenDataProvider);

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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              SearchBar(
                controller: _searchController,
                hintText: 'Search Pokemon',
                hintStyle: MaterialStatePropertyAll(
                  TextStyle(
                    color: Colors.white.withAlpha(100),
                  ),
                ),
                trailing: [
                  _searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : GestureDetector(
                          child: const Icon(Icons.delete_rounded),
                          onTap: () => _searchController.clear(),
                        )
                ],
                elevation: const MaterialStatePropertyAll(5),
                backgroundColor:
                    MaterialStatePropertyAll(Colors.amber.withAlpha(50)),
                shadowColor: MaterialStatePropertyAll(Colors.orange[900]),
                surfaceTintColor: const MaterialStatePropertyAll(Colors.orange),
                side: MaterialStatePropertyAll(
                  BorderSide(
                      style: BorderStyle.solid, color: Colors.orange[900]!),
                ),
                onSubmitted: (value) {},
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1010 ~/ 30 + 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        updateSection(index * 30);
                      },
                      child: Container(
                        height: 40,
                        width: 85,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: startIndex == index * 30
                              ? Colors.pinkAccent.withAlpha(225)
                              : Colors.pinkAccent.withAlpha(100),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.pinkAccent,
                          ),
                        ),
                        child: Text(
                          '${index * 30 + 1} - ${index * 30 + 30}',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.amber,
                  onRefresh: _onRefresh,
                  child: pokemonData.when(
                    data: (pokemonMap) {
                      final filteredPokemon = pokemonMap.entries
                          .where((entry) =>
                              entry.key.toLowerCase().contains(searchQuery))
                          .toList();

                      final visiblePokemon = searchQuery.isEmpty
                          ? pokemonMap.entries
                              .skip(startIndex)
                              .take(30)
                              .toList()
                          : filteredPokemon;

                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemCount: visiblePokemon.length,
                              itemBuilder: (context, index) {
                                final pokemonName = visiblePokemon[index].key;
                                final pokemonImageUrl =
                                    visiblePokemon[index].value;

                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PokemonPage(
                                            pokemonName: pokemonName);
                                      },
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent.withAlpha(100),
                                      borderRadius: BorderRadius.circular(15),
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          pokemonImageUrl,
                                          height: 80,
                                          width: 80,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.image_not_supported,
                                              size: 60,
                                              color: Colors.white,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          pokemonName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text('Error: $error')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
