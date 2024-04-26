part of 'auth_repository.dart';

abstract class AuthProvider {
  Future<AuthUser?> getCurrentUserData();
  Future<AuthUser?> loginUser({
    required String username,
    required String password,
  });
  Future<void> createUser({
    required String username,
    required String password,
    required String email,
    required String name,
  });
  Future<void> signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  });
  void verifyOTP({
    required String verificationId,
    required String userOTP,
  });
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
}
