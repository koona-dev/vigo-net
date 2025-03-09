import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:isp_app/features/authentication/presentation/auth/otp_view.dart';
import 'package:isp_app/features/authentication/presentation/auth_exception.dart';

class AuthRepository {
  final auth = FirebaseAuth.instance;

  User get user => auth.currentUser!;

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
          throw Exception(e);
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
      throw Exception(e);
    }
  }

  Future<void> verifyOTP({
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
      throw Exception(e);
    }
  }

  Future<UserCredential> signup(
      {required String email, required String password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    if (auth.currentUser != null) {
      await auth.signOut();
    } else {
      throw UserNotLoginException();
    }
  }
}
