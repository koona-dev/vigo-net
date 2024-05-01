import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/common/repositories/image_storage_repository.dart';
import 'package:isp_app/features/auth/repository/auth_exception.dart';
import 'package:isp_app/features/auth/views/otp_view.dart';
import 'package:isp_app/model/auth_user.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<AuthUser?> getCurrentUserData() async {
    AuthUser? userData;
    User? currentUser = auth.currentUser;

    if (currentUser != null) {
      final userFromDB =
          await firestore.collection('users').doc(currentUser.uid).get();
      userData = AuthUser.fromMap(userFromDB.data()!);
    }
    return userData;
  }

  Future<void> signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          print('VERIFICATION ID : $verificationId');
          Navigator.of(context).pushReplacementNamed(
            OTPView.routeName,
            arguments: {'verificationId': verificationId},
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  void verifyOTP({
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );

      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> createUser({
    required String username,
    required String password,
    required String email,
    required String name,
  }) async {
    try {
      final currentUser = auth.currentUser!;

      final user = AuthUser(
        username: username,
        password: password,
        email: email,
        phone: currentUser.phoneNumber!,
        name: name,
      );

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .set(user.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AuthUser?> loginUser({
    required String username,
    required String password,
  }) async {
    final userId = auth.currentUser?.uid;
    final user = await firestore.collection('users').doc(userId).get().then(
      (doc) {
        final data = doc.data();

        if (username == data?['username'] && password == data?['password']) {
          return AuthUser.fromMap(data!);
        }
      },
    );

    return user;
  }

  void saveUserInformationToDb({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
    required ProviderRef ref,
  }) async {
    try {
      final uid = auth.currentUser?.uid;
      List<String> photoUrl = [
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'
      ];

      photoUrl = await ref.read(imageStorageRepositoryProvider).uploadFiles(
            ref: 'photoRumah/$uid',
            files: photoRumah,
          );

      var user = AuthUser(
        address: address,
        noKtp: noKtp,
        housePhotoUrl: photoUrl,
      );

      await firestore.collection('users').doc(uid).update(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<AuthUser> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => AuthUser.fromMap(
            event.data()!,
          ),
        );
  }

  Future<void> sendPasswordReset(String password) async {
    try {
      final uid = auth.currentUser?.uid;
      await firestore
          .collection('users')
          .doc(uid)
          .update({'password': password});
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    if (auth.currentUser != null) {
      await auth.signOut();
    } else {
      throw UserNotLoginException();
    }
  }
}
