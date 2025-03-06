import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:isp_app/features/authentication/presentation/auth/otp_view.dart';
import 'package:isp_app/features/authentication/presentation/auth_exception.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');

  User get currentUser => auth.currentUser!;

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

      await firestore.doc(currentUser.uid).set(user.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<AuthUser?> loginUser({
    required String username,
    required String password,
  }) async {
    final userId = auth.currentUser?.uid;
    final user = await firestore.doc(userId).get().then(
      (doc) {
        final data = doc.data();

        if (username == data?['username'] && password == data?['password']) {
          return AuthUser.fromMap({'id': doc.id, ...data!});
        }
      },
    );

    return user;
  }

  Future<void> sendPasswordReset(String password) async {
    try {
      final uid = auth.currentUser?.uid;
      await firestore.doc(uid).update({'password': password});
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

  Future<void> deleteUser() async {}
}
