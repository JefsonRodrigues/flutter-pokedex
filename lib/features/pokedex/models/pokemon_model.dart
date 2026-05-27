import 'dart:convert';
import 'dart:ui';

class PokemonModel {
  int? id;
  String name;
  String url;
  List<String>? types;
  String? imageUrl;
  String? imageUrlDetails;
  Color? color;
  List<String>? abilities;
  double? height;
  double? weight;
  int? hp;
  int? attack;
  int? defense;
  int? specialAttack;
  int? specialDefense;
  int? speed;

  PokemonModel({
    this.id,
    required this.name,
    required this.url,
    this.types = const [],
    this.abilities = const [],
    this.imageUrl,
    this.color,
    this.imageUrlDetails,
    this.height,
    this.weight,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'types': types,
      'imageUrl': imageUrl,
      'imageUrlDetails': imageUrlDetails,
      'color': color?.toARGB32(),
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'],
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      types:
          (map['types'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      abilities:
          (map['abilities'] as List?)?.map((e) => e.toString()).toList() ??
          const [],
      imageUrl: map['imageUrl'],
      imageUrlDetails: map['imageUrlDetails'],
      color: map['color'] != null ? Color(map['color']) : null,
      height: (map['height'] as num?)?.toDouble() ?? 0.0,
      weight: (map['weight'] as num?)?.toDouble() ?? 0.0,
      hp: map['hp'] ?? 0,
      attack: map['attack'] ?? 0,
      defense: map['defense'] ?? 0,
      specialAttack: map['specialAttack'] ?? 0,
      specialDefense: map['specialDefense'] ?? 0,
      speed: map['speed'] ?? 0,
    );
  }
  String toJson() => jsonEncode(toMap());

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(jsonDecode(source));
}
