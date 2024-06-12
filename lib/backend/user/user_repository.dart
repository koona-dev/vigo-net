import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/auth/auth_repository.dart';
import 'package:isp_app/backend/user/user.dart';
import 'package:isp_app/common/repositories/image_storage_repository.dart';

final userRepoProvider = Provider(
  (ref) => UserRepository(
    firestore: FirebaseFirestore.instance,
    currentUser: ref.watch(authRepoProvider).currentUser,
  ),
);

class UserRepository {
  final FirebaseFirestore firestore;
  final User currentUser;

  UserRepository({
    required this.firestore,
    required this.currentUser,
  });

  Future<AuthUser?> getCurrentUserDataFromDb() async {
    AuthUser? userData;

    final userFromDB =
        await firestore.collection('users').doc(currentUser.uid).get();
    userData = AuthUser.fromMap(id: userFromDB.id, data: userFromDB.data()!);
    return userData;
  }

  void saveUserInformationToDb({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
    required ProviderRef ref,
  }) async {
    try {
      List<String> photoUrl = [
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'
      ];

      photoUrl = await ref.read(imageStorageRepositoryProvider).uploadFiles(
            ref: 'photoRumah/${currentUser.uid}',
            files: photoRumah,
          );

      var user = AuthUser(
        address: address,
        noKtp: noKtp,
        housePhotoUrl: photoUrl,
      );

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<AuthUser> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => AuthUser.fromMap(
            id: event.id,
            data: event.data()!,
          ),
        );
  }

  void updateUser(Map<String, dynamic> dataUser) async {
    await firestore.collection('users').doc(currentUser.uid).update(dataUser);
  }
}
