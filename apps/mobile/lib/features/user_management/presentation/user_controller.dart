import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/core/services/image_service.dart';
import 'package:vigo_net_mobile/features/authentication/data/auth_repository.dart';
import 'package:vigo_net_mobile/features/user_management/data/user_repository.dart';
import 'package:vigo_net_mobile/features/user_management/domain/user.dart';

final userControllerProvider = Provider.autoDispose((ref) {
  return UserController(ref);
});

final userDataProvider = FutureProvider.autoDispose((ref) {
  final userController = ref.watch(userControllerProvider);
  return userController.userData;
});

class UserController {
  final Ref ref;
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  UserController(this.ref);

  Future<AuthUser?> get userData async {
    return await _userRepository.findOne(uid: _authRepository.user?.uid);
  }

  Future<void> addUserInformation({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
  }) async {
    final uid = _authRepository.user?.uid;
    final imageService = ImageService();
    final List<String> photoUrl = await imageService.uploadFiles(
      ref: 'photoRumah/${uid}',
      files: photoRumah,
    );

    var user = AuthUser(
      id: _authRepository.user?.uid,
      address: address,
      noKtp: noKtp,
      housePhotoUrl: photoUrl,
    );

    _userRepository.update(user);
  }

  void editProfile(AuthUser user) {
    _userRepository.update(user);
  }

  void deleteAccount() {
    _userRepository.delete(_authRepository.user!.uid);
  }
}
