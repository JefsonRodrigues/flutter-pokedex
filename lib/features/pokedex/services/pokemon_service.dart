import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:pokedex/core/utils/pokemon_type_colors.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2',
      connectTimeout: const Duration(
        seconds: 10,
      ),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<PokemonModel>> getPokemons(int offset) async {
    try {
      final response = await _dio.get('/pokemon?limit=20&offset=$offset');
      final List<dynamic> results = response.data['results'];
      List<PokemonModel> listaDePokemons = [];
      for (var pokemonMap in results) {
        final String detalheUrl = pokemonMap['url'] ?? '';
        final String nomeRaw = pokemonMap['name'] ?? '';
        final String nomeFormatado = nomeRaw.isNotEmpty
            ? '${nomeRaw[0].toUpperCase()}${nomeRaw.substring(1)}'
            : '';
        if (detalheUrl.isNotEmpty) {
          try {
            final detalheResponse = await _dio.get(detalheUrl);
            final Map<String, dynamic> detalheData = detalheResponse.data;
            final int pokemonId = detalheData['id'];
            final String pokemonImage =
                detalheData['sprites']?['front_default'] ?? '';
            final List<dynamic> types = detalheData['types'] ?? [];
            List<String> pokemonTypes = types.map((typeData) {
              return typeData['type']['name'].toString();
            }).toList();
            final imageUrlDetails =
                detalheData['sprites']?['other']?['official-artwork']?['front_default'];

            final List<dynamic> abilities = detalheData['moves'];
            final List<String> ability = abilities.take(4).map(
              (e) {
                return e['move']['name'].toString();
              },
            ).toList();
            final double height = detalheData['height'] / 10;
            final double weight = detalheData['weight'] / 10;

            final hp = detalheData['stats'][0]['base_stat'] ?? 0;
            final attack = detalheData['stats'][1]['base_stat'] ?? 0;
            final defense = detalheData['stats'][2]['base_stat'] ?? 0;
            final specialAttack = detalheData['stats'][3]['base_stat'] ?? 0;
            final specialDefense = detalheData['stats'][4]['base_stat'] ?? 0;
            final speed = detalheData['stats'][5]['base_stat'] ?? 0;

            final pokemon = PokemonModel(
              id: pokemonId,
              name: nomeFormatado,
              url: detalheUrl,
              types: pokemonTypes,
              height: height,
              weight: weight,
              abilities: ability,
              imageUrl: pokemonImage,
              imageUrlDetails: imageUrlDetails,
              color: pokemonTypes.isNotEmpty
                  ? getColorByType(pokemonTypes.first)
                  : null,
              hp: hp,
              attack: attack,
              defense: defense,
              specialAttack: specialAttack,
              specialDefense: specialDefense,
              speed: speed,
            );
            listaDePokemons.add(pokemon);
          } catch (e) {
            developer.log('Erro ao puxar detalhes de $nomeFormatado: $e');
          }
        }
      }
      return listaDePokemons;
    } on DioException catch (e) {
      developer.log('Erro na requisição do Dio: ${e.message}', error: e);
    } catch (e) {
      developer.log('Erro inesperado: $e');
    }
    return [];
  }

  Future<void> savePokemon(List<PokemonModel> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    final listPokemon = pokemons.map((pokemon) => pokemon.toJson()).toList();
    await prefs.setStringList('pokemons', listPokemon);
  }

  Future<List<PokemonModel>> listarPokemon() async {
    final prefs = await SharedPreferences.getInstance();
    final listPokemon = prefs.getStringList('pokemons');
    if (listPokemon == null) return [];
    return listPokemon.map((item) => PokemonModel.fromJson(item)).toList();
  }
}
