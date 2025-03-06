import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class UserRepository {
  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<AuthUser?> getCurrentUserDataFromDb() async {
    final userFromDB =
        await firestore.collection('users').doc(currentUser.uid).get();
    final userData =
        AuthUser.fromMap({'id': userFromDB.id, ...userFromDB.data()!});
    return userData;
  }

  void saveUserInformationToDb(
      {required String address,
      required String noKtp,
      required List<String> photoUrl,
      photo}) async {
    try {
      List<String> photoUrl = [
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'
      ];

      var user = AuthUser(
        address: address,
        noKtp: noKtp,
        housePhotoUrl: photoUrl,
      );

      await firestore
          .collection('users')
          .doc(currentUser.uid)
          .update(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Stream<AuthUser> userData(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => AuthUser.fromMap({'id': event.id, ...event.data()!}));
  }

  void updateUser(Map<String, dynamic> dataUser) async {
    await firestore.collection('users').doc(currentUser.uid).update(dataUser);
  }
}
