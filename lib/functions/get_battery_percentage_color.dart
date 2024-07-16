import 'package:flutter/material.dart';

Color getColor(int percentage) {
  if (percentage >= 85 && percentage <= 100) {
    return Colors.green;
  } else if (percentage >= 40 && percentage < 85) {
    // Interpolate between yellow and green
    return Colors.yellow;
  } else if (percentage > 0 && percentage < 40) {
    // Interpolate between red and yellow
    return Colors.red;
  } else {
    return Colors.grey;
  }
}
