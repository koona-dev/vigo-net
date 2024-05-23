import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/auth/repository/auth_repository.dart';
import 'package:isp_app/model/auth_user.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<AuthUser?> getUserData() async {
    AuthUser? user = await authRepository.getCurrentUserData();
    return user;
  }

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

  void saveUserInformationToDb({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
  }) {
    authRepository.saveUserInformationToDb(
      address: address,
      noKtp: noKtp,
      photoRumah: photoRumah,
      ref: ref,
    );
  }

  void editProfile(Map<String, dynamic> data) {
    authRepository.updateUserProfile(data);
  }

  void signOut() {
    authRepository.signOut();
  }
}
