import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<AuthUser?> findOne({String? uid, Query? filter}) async {
    if (uid != null) {
      return await _firestore.collection('users').doc(uid).get().then((doc) {
        return AuthUser.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      });
    }
    return await filter?.get().then((QuerySnapshot querySnapshot) {
      final doc = querySnapshot.docs.first;
      return AuthUser.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Stream<AuthUser> findOneStream(Query filter) {
    return filter.snapshots().map((snapshot) {
      final doc = snapshot.docs.first;
      return AuthUser.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Future<void> create(AuthUser userData) async {
    try {
      await _firestore.collection('users').doc().set(userData.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> update(AuthUser userData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userData.id)
          .update(userData.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(String id) async {
    await _firestore.collection('users').doc(id).delete();
  }
}
