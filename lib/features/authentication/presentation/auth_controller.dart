import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/authentication/data/auth_repository.dart';
import 'package:isp_app/features/user_management/data/user_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/features/user_management/domain/user.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  return AuthController();
});

final loginProvider = FutureProvider.family
    .autoDispose<AuthUser?, ({String username, String password})>(
        (ref, input) async {
  final authController = ref.watch(authControllerProvider);
  return await authController.loginUser(
      username: input.username, password: input.password);
});

class AuthController {
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  User? get currentUserLogin => _authRepository.user;

  void signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    try {
      await _authRepository.signInWithPhone(
        context,
        phoneNumber: phoneNumber,
      );
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  void verifyOTP({
    required String verificationId,
    required String userOTP,
  }) {
    _authRepository.verifyOTP(
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void registerUser({
    required String username,
    required String password,
    required String email,
    required String name,
  }) async {
    try {
      final result =
          await _authRepository.signup(email: email, password: password);
      final user = AuthUser(
        id: result.user?.uid,
        username: username,
        password: password,
        email: email,
        name: name,
      );
      await _userRepository.create(user);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<AuthUser?> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      print('$username && $password');
      final filter = getFilteredQuery('users', {
        'username': {'isEqualTo', username},
        'password': {'isEqualTo', password}
      });

      final user = await _userRepository.findOne(filter: filter);

      await _authRepository.loginUser(
        email: user!.email!,
        password: password,
      );
      print('USER = $user');

      return user;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  void resetPassword(String password) async {
    await _userRepository.update(AuthUser(password: password));
  }

  void signOut() async {
    await _authRepository.signOut();
  }
}
