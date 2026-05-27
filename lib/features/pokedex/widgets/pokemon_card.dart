import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/presentation/pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback? onFavoriteTap;
  final bool exibirFavorito;
  final bool isFavorite;
  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onFavoriteTap,
    this.exibirFavorito = true,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedNumber = pokemon.id != null
        ? '#${pokemon.id.toString().padLeft(3, '0')}'
        : '#???';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailsPage(
                pokemon: pokemon,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: pokemon.color ?? Colors.black,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    pokemon.types != null && pokemon.types!.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: pokemon.types!.map((typeName) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(
                                    alpha: 0.25,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  typeName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Desconhecido',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (exibirFavorito)
                    IconButton(
                      onPressed: () {
                        onFavoriteTap?.call();
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  pokemon.imageUrl != null && pokemon.imageUrl!.isNotEmpty
                      ? Hero(
                          tag: pokemon.id!,
                          child: ClipRRect(
                            child: Image.network(
                              pokemon.imageUrl!,
                              height: 110,
                              width: 110,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.catching_pokemon,
                          size: 110,
                          color: Colors.white,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
