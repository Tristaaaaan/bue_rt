// Define a StreamProvider to provide the speed stream

import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final speedProvider = StreamProvider<double>((ref) {
  // Start listening to the position stream
  return Geolocator.getPositionStream().map((Position position) {
    return position.speed; // Speed in meters per second
  });
  // Test
  // return Stream.value(3.0);
});
