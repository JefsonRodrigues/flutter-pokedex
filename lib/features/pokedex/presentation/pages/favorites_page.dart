import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_card.dart';
import 'package:pokedex/features/provider/favorite_provider.dart';

class Favoritespage extends ConsumerStatefulWidget {
  const Favoritespage({super.key});

  @override
  ConsumerState<Favoritespage> createState() => _FavoritespageState();
}

class _FavoritespageState extends ConsumerState<Favoritespage> {
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteProvider);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pokémon favoritados',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore os Pokémon...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: favorites.isEmpty
                ? Center(
                    child: Text('Nenhum Pokémon favoritado ainda.'),
                  )
                : ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return PokemonCard(
                        pokemon: favorites[index],
                        exibirFavorito: false,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
