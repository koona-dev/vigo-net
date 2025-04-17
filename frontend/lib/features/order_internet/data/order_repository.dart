import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';

class OrderRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<Orders?> findOne({String? docId, Query? filter}) async {
    if (docId != null) {
      return await _firestore.collection('orders').doc(docId).get().then((doc) {
        return Orders.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      });
    }

    return await filter?.limit(1).get().then((QuerySnapshot querySnapshot) {
      final doc = querySnapshot.docs.first;
      return Orders.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Stream<List<Orders>> findMany(Query filter) {
    return filter.snapshots().map(
          (collection) => collection.docs.map(
            (doc) {
              return Orders.fromMap(
                  {'id': doc.id, ...doc.data() as Map<String, dynamic>});
            },
          ).toList(),
        );
  }

  Future<void> insert(Orders orders) async {
    try {
      await _firestore.collection('orders').doc().set(orders.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  void delete(String orderId) {
    _firestore.collection('orders').doc(orderId).delete();
  }
}
