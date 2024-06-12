import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/auth/auth_repository.dart';
import 'package:isp_app/backend/user/user.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  User get user => authRepository.currentUser;

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
