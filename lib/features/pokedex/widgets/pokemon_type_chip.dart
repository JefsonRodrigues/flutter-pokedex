import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';

class Pokemontypechip extends StatelessWidget {
  final PokemonModel pokemon;
  const Pokemontypechip({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: (pokemon.types ?? ['Desconhecido']).map((
          typeName,
        ) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              typeName[0].toUpperCase() + typeName.substring(1),
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
