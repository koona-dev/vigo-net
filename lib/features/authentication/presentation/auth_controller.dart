import 'package:flutter/material.dart';
import 'package:isp_app/features/authentication/data/auth_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/features/user_management/domain/user.dart';

final authController = Provider((ref) {
  return AuthController();
});

class AuthController {
  final AuthRepository authRepository = AuthRepository();

  void signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    await authRepository.signInWithPhone(
      context,
      phoneNumber: phoneNumber,
    );
  }

  void verifyOTP({
    required String verificationId,
    required String userOTP,
  }) {
    authRepository.verifyOTP(
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void registerUser({
    required String username,
    required String password,
    required String email,
    required String name,
  }) {
    authRepository.createUser(
      username: username,
      password: password,
      email: email,
      name: name,
    );
  }

  Future<AuthUser?> loginUser({
    required String username,
    required String password,
  }) {
    return authRepository.loginUser(
      username: username,
      password: password,
    );
  }

  void resetPassword(String password) {
    authRepository.sendPasswordReset(password);
  }

  void signOut() {
    authRepository.signOut();
  }
}
