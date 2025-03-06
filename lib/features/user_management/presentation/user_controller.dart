import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/core/services/image_storage_repository.dart';
import 'package:isp_app/features/user_management/data/user_repository.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

final userControllerProvider = Provider((ref) {
  return UserController(ref);
});

final userDataProvider = FutureProvider((ref) {
  final userController = ref.watch(userControllerProvider);
  return userController.getCurrentUserData();
});

class UserController {
  final Ref ref;
  final UserRepository userRepository = UserRepository();

  UserController(this.ref);

  Future<AuthUser?> getCurrentUserData() async {
    AuthUser? user = await userRepository.getCurrentUserDataFromDb();
    return user;
  }

  Future<void> saveUserInformationToDb({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
  }) async {
    final currentUser = await getCurrentUserData();
    final List<String> photoUrl =
        await ref.read(imageStorageRepositoryProvider).uploadFiles(
              ref: 'photoRumah/${currentUser?.id}',
              files: photoRumah,
            );

    userRepository.saveUserInformationToDb(
      address: address,
      noKtp: noKtp,
      photoUrl: photoUrl,
    );
  }

  void editProfile(Map<String, dynamic> data) {
    userRepository.updateUser(data);
  }
}
