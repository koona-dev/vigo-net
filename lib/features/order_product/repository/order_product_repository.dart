import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/auth_user.dart';
import 'package:isp_app/model/order.dart';

final orderProductRepoProvider = Provider(
  (ref) => OrderProductRepository(FirebaseFirestore.instance),
);

class OrderProductRepository {
  final FirebaseFirestore firestore;
  OrderProductRepository(this.firestore);

  Future<bool> isOrder(String userId) async {
    return await firestore.collection('orders').get().then(
          (collection) => collection.docs.any(
            (doc) => doc.data()['userId'] == userId,
          ),
        );
  }

  void insertOrderProduct({
    required String userId,
    required List<Cart> cartItems,
    required DateTime tanggalOrder,
    required String jenisPelayanan,
    required String status,
  }) {
    try {
      Orders orders = Orders(
        userId: userId,
        cartItems: cartItems,
        tanggalOrder: tanggalOrder,
        jenisPelayanan: jenisPelayanan,
        status: status,
      );

      firestore.collection('orders').doc().set(orders.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Orders> getOrderData(AuthUser user) async {
    final orderDoc = await firestore.collection('orders').get().then(
          (collection) => collection.docs.firstWhere(
            (doc) => doc.data()['userId'] == user.id,
          ),
        );

    return Orders.fromMap(id: orderDoc.id, data: orderDoc.data());
  }
}
