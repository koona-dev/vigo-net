import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/order.dart';

final orderProductRepoProvider = Provider(
  (ref) => OrderProductRepository(FirebaseFirestore.instance),
);

class OrderProductRepository {
  final FirebaseFirestore firestore;
  OrderProductRepository(this.firestore);

  Future<bool> isOrderPasangBaru(String userId) async {
    return await firestore.collection('orders').get().then(
          (collection) => collection.docs.any(
            (doc) =>
                doc.data()['userId'] == userId &&
                doc.data()['jenisPemesanan'] == JenisPemesanan.pasangBaru.name,
          ),
        );
  }

  void insertOrderProduct({
    required String userId,
    required List<Cart> cartItems,
    required DateTime tanggalOrder,
    required String status,
  }) {
    try {
      Orders orders = Orders(
        userId: userId,
        cartItems: cartItems,
        tanggalOrder: tanggalOrder,
        status: status,
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
