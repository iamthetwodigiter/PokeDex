class Pokemon {
  final int id;
  final String name;
  final int generation;
  final String species;
  final List<String> types;
  final List<Map<String, dynamic>> abilities;
  final String height;
  final String weight;
  final bool mega;
  final Map<String, int> stats;
  final Map<String, String> training;
  final Map<String, dynamic> breeding;
  final String image;

  Pokemon({
    required this.id,
    required this.name,
    required this.generation,
    required this.species,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.mega,
    required this.stats,
    required this.training,
    required this.breeding,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'generation': generation,
      'species': species,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'mega': mega,
      'stats': stats,
      'training': training,
      'breeding': breeding,
      'image': image,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['number'] as int,
      name: map['name'] as String,
      generation: map['gen'] as int,
      species: map['species'] as String,
      types: List<String>.from((map['types'] as List<dynamic>)),
      abilities: List<Map<String, dynamic>>.from(
          (map['abilities'] as List<dynamic>).map((x) => Map<String, dynamic>.from(x as Map))),
      height: map['height'] as String,
      weight: map['weight'] as String,
      mega: map['mega'] as bool,
      stats: Map<String, int>.from((map['baseStats'] as Map<String, dynamic>)),
      training: Map<String, String>.from((map['training'] as Map<String, dynamic>)),
      breeding: Map<String, dynamic>.from((map['breeding'] as Map<String, dynamic>)),
      image: map['sprite'] as String,
    );
  }
}
