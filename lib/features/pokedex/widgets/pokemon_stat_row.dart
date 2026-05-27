import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonStatRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const PokemonStatRow({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 45,
          child: Text(
            value.toString(),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (value / 150.0).clamp(0.0, 1.0),
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: AlwaysStoppedAnimation<Color>(
                color.withValues(alpha: 1.0),
              ),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
