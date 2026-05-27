import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_stat_row.dart';

class PokemonStatsSection extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonStatsSection({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = pokemon.color ?? Colors.teal.shade300;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      color: Colors.white.withValues(alpha: 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Base Stats',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 16),
          PokemonStatRow(
            label: 'Hp',
            value: pokemon.hp ?? 0,
            color: baseColor,
          ),
          PokemonStatRow(
            label: 'Attack',
            value: pokemon.attack ?? 0,
            color: baseColor,
          ),
          PokemonStatRow(
            label: 'Defense',
            value: pokemon.defense ?? 0,
            color: baseColor,
          ),
          PokemonStatRow(
            label: 'Sp. Atk',
            value: pokemon.specialAttack ?? 0,
            color: baseColor,
          ),
          PokemonStatRow(
            label: 'Sp. Def',
            value: pokemon.specialDefense ?? 0,
            color: baseColor,
          ),
          PokemonStatRow(
            label: 'Speed',
            value: pokemon.speed ?? 0,
            color: baseColor,
          ),
        ],
      ),
    );
  }
}
