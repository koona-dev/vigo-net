import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/user/user.dart';
import 'package:isp_app/backend/user/user_repository.dart';

final userControllerProvider = Provider((ref) {
  final userRepository = ref.watch(userRepoProvider);
  return UserController(userRepository: userRepository, ref: ref);
});

final userDataProvider = FutureProvider((ref) {
  final userController = ref.watch(userControllerProvider);
  return userController.getCurrentUserData();
});

class UserController {
  final UserRepository userRepository;
  final ProviderRef ref;
  UserController({
    required this.userRepository,
    required this.ref,
  });

  Future<AuthUser?> getCurrentUserData() async {
    AuthUser? user = await userRepository.getCurrentUserDataFromDb();
    return user;
  }

  void saveUserInformationToDb({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
  }) {
    userRepository.saveUserInformationToDb(
      address: address,
      noKtp: noKtp,
      photoRumah: photoRumah,
      ref: ref,
    );
  }

  void editProfile(Map<String, dynamic> data) {
    userRepository.updateUser(data);
  }
}
