import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider(
  (ref) => UserProfileRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class UserProfileRepository {
  final FirebaseFirestore firestore;

  UserProfileRepository({required this.firestore});
}
