import 'package:flutter_riverpod/legacy.dart';

import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/services/pokemon_service.dart';

class FavoriteNotifier extends StateNotifier<List<PokemonModel>> {
  FavoriteNotifier() : super([]);
  final PokemonService _service = PokemonService();

  Future<void> addPokemon(PokemonModel pokemon) async {
    state = [...state, pokemon];
    await _service.savePokemon(state);
  }

  Future<void> removePokemon(PokemonModel pokemon) async {
    state = state.where((e) => e.id != pokemon.id).toList();
    await _service.savePokemon(state);
  }

  Future<void> loadFavorites() async {
    final list = await _service.listarPokemon();

    state = list;
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<PokemonModel>>((ref) {
      return FavoriteNotifier();
    });
