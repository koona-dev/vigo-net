import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/order_product/controller/order_product_controller.dart';
import 'package:isp_app/model/auth_user.dart';
import 'package:isp_app/model/order.dart';

final orderProductRepoProvider = Provider(
  (ref) => OrderProductRepository(FirebaseFirestore.instance),
);

class OrderProductRepository {
  final FirebaseFirestore firestore;
  OrderProductRepository(this.firestore);

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

  Future<CheckoutNote> getOrderData({
    required AuthUser user,
    required CartNotifier cartNotifier,
  }) async {
    final doc = await firestore.collection('orders').get().then(
          (collection) => collection.docs.firstWhere(
            (doc) => doc.data()['userId'] == user.id,
          ),
        );

    final order = Orders.fromMap(
      id: doc.id,
      data: doc.data(),
    );

    final note = CheckoutNote(
      nama: user.name!,
      noHp: user.phone!,
      alamat: user.address!,
      products: order.cartItems,
      totalHarga: cartNotifier.subTotalPrice,
    );

    return note;
  }
}
