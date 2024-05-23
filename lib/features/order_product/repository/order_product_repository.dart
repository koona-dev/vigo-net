import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/order.dart';

final orderProductRepoProvider = Provider(
  (ref) => OrderProductRepository(FirebaseFirestore.instance),
);

class OrderProductRepository {
  final FirebaseFirestore firestore;
  OrderProductRepository(this.firestore);

  Future<Orders?> currentOrder(String userId) async {
    final collection = await firestore
        .collection('orders')
        .orderBy('tanggalOrder', descending: true)
        .get();
    final docList = collection.docs;
    final doc = docList.firstWhere(
      (element) {
        final data = element.data();
        return data['userId'] == userId &&
            data['jenisPemesanan'] == JenisPemesanan.pasangBaru.name;
      },
    );
    final order = Orders.fromMap(id: doc.id, data: doc.data());
    return order;
  }

  void insertOrderProduct({
    required String userId,
    required List<Cart> cartItems,
    required DateTime tanggalOrder,
    required int totalHarga,
  }) {
    try {
      Orders orders = Orders(
        userId: userId,
        cartItems: cartItems,
        tanggalOrder: tanggalOrder,
        totalHarga: totalHarga,
      );

      firestore.collection('orders').doc().set(orders.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<Orders?>> getOrdersByUser(String userId) {
    final orderList = firestore.collection('orders').snapshots().map(
          (collection) => collection.docs.map(
            (doc) {
              if (doc.data()['userId'] == userId) {
                return Orders.fromMap(id: doc.id, data: doc.data());
              }
            },
          ).toList(),
        );

    return orderList;
  }

  void deleteOrder(String orderId) {
    firestore.collection('orders').doc(orderId).delete();
  }
}
