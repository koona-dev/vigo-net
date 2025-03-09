import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance;

  Future<Orders> findOne(Query filter) async {
    final snapshot = await filter.limit(1).get();

    final doc = snapshot.docs.first;
    final order =
        Orders.fromMap(id: doc.id, data: doc.data() as Map<String, dynamic>);
    return order;
  }

  Stream<List<Orders>> findMany(Query filter) {
    return filter.snapshots().map(
          (collection) => collection.docs.map(
            (doc) {
              return Orders.fromMap(
                  id: doc.id, data: doc.data() as Map<String, dynamic>);
            },
          ).toList(),
        );
  }

  Future<void> insert(Orders orders) async {
    try {
      await firestore.collection('orders').doc().set(orders.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  void delete(String orderId) {
    firestore.collection('orders').doc(orderId).delete();
  }
}
