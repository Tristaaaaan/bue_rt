import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

final databaseProvider = StreamProvider((ref) {
  final database = FirebaseDatabase.instance.ref('EVData');
  return database.onValue.map((event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>;
    return data;
  });
});
