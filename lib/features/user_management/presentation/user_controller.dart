import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/core/services/image_storage_repository.dart';
import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/authentication/data/auth_repository.dart';
import 'package:isp_app/features/user_management/data/user_repository.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

final userControllerProvider = Provider.autoDispose((ref) {
  return UserController(ref);
});

final currentUserProvider = FutureProvider.autoDispose((ref) {
  final userController = ref.watch(userControllerProvider);
  return userController.getCurrentUser;
});

class UserController {
  final Ref ref;
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  UserController(this.ref);

  Future<AuthUser?> get getCurrentUser async {
    final filter = getFilteredQuery('users', {
      'id': {'isEqualTo': _authRepository.user.uid}
    });
    return await _userRepository.findOne(filter);
  }

  Future<void> addUserInformation({
    required String address,
    required String noKtp,
    required List<File?> photoRumah,
  }) async {
    final uid = _authRepository.user.uid;
    final List<String> photoUrl =
        await ref.read(imageStorageRepositoryProvider).uploadFiles(
              ref: 'photoRumah/${uid}',
              files: photoRumah,
            );

    var user = AuthUser(
      id: _authRepository.user.uid,
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
    _userRepository.delete(_authRepository.user.uid);
  }
}
