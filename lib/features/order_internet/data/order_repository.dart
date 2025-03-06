import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/order_internet/domain/cart.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/order_internet/domain/types.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance;

  Future<Orders?> currentOrder(String userId) async {
    final snapshot = await firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .where('jenisPemesanan', isEqualTo: JenisPemesanan.pasangBaru.name)
        .limit(1)
        .get();

    final doc = snapshot.docs.first;
    final order = Orders.fromMap(id: doc.id, data: doc.data());
    return order;
  }

  void insertOrder({
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
        masaBerlakuPaket: 30,
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
