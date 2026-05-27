import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_about_section.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_stats_section.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type_chip.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final String formattedNumber = pokemon.id != null
        ? '#${pokemon.id.toString().padLeft(3, '0')}'
        : '#???';
    final Color baseColor = pokemon.color ?? Colors.teal.shade300;
    final HSLColor hsl = HSLColor.fromColor(baseColor);
    final Color lighterColor = hsl
        .withLightness((hsl.lightness + 0.08).clamp(0.0, 1.0))
        .toColor();
    final Color darkerColor = hsl
        .withLightness((hsl.lightness - 0.12).clamp(0.0, 1.0))
        .toColor();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [lighterColor, baseColor, darkerColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          pokemon.name,
                          style: GoogleFonts.outfit(
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.8,
                            height: 1.1,
                          ),
                        ),
                      ),
                      Text(
                        formattedNumber,
                        style: GoogleFonts.outfit(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.65),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Pokemontypechip(
                  pokemon: pokemon,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.22),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 220,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.white.withValues(alpha: 0.25),
                                          Colors.white.withValues(alpha: 0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pokemon.imageUrlDetails != null &&
                                          pokemon.imageUrlDetails!.isNotEmpty
                                      ? Hero(
                                          tag: pokemon.id!,
                                          child: ClipRRect(
                                            child: Image.network(
                                              pokemon.imageUrlDetails!,
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.catching_pokemon,
                                          size: 150,
                                          color: Colors.white,
                                        ),
                                ],
                              ),
                              PokemonAboutSection(
                                pokemon: pokemon,
                              ),
                              Container(
                                height: 1.5,
                                width: double.infinity,
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                              PokemonStatsSection(
                                pokemon: pokemon,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
