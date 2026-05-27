import 'package:flutter/material.dart';

Color getColorByType(String type) {
  switch (type.toLowerCase()) {
    case 'grass':
      return Colors.green.shade300;
    case 'fire':
      return Colors.red.shade300;
    case 'water':
      return Colors.blue.shade300;
    case 'poison':
      return Colors.purple.shade300;
    case 'electric':
      return Colors.yellow.shade300;
    default:
      return Colors.grey;
  }
}
