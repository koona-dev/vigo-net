import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/order_internet/data/order_repository.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/order_internet/domain/types.dart';
import 'package:isp_app/features/order_internet/presentation/cart_controller.dart';
import 'package:isp_app/features/user_management/domain/types.dart';
import 'package:isp_app/features/user_management/domain/user.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

class OrderController {
  final AuthUser? currentUser;
  final Ref ref;
  OrderController({required this.ref, this.currentUser});

  final _orderRepository = OrderRepository();

  Future<Orders?> get currentOrder async {
    final filter = getFilteredQuery('orders', {
      'userId': {
        'isEqualTo': currentUser?.id,
      },
      'jenisPemesanan': {'isEqualTo': JenisPemesanan.pasangBaru.name},
    });
    return await _orderRepository.findOne(filter);
  }

  Stream<List<Orders>> getOrdersByUser() {
    final filter = getFilteredQuery('orders', {
      'userId': {
        'isEqualTo': currentUser?.id,
      },
    });
    return _orderRepository.findMany(filter);
  }

  void createOrder() async {
    try {
      final cartData = ref.watch(cartProvider);

      final orders = Orders(
        cartItems: cartData.cartItems,
        userId: currentUser!.id!,
        tanggalOrder: DateTime.now(),
        totalHarga: cartData.subTotalPrice,
        masaBerlakuPaket: 30,
      );

      ref
          .read(userControllerProvider)
          .editProfile(AuthUser(id: currentUser!.id!, role: UserRole.cp));
      await _orderRepository.insert(orders);
    } catch (e) {
      rethrow;
    }
  }

  void cancelOrder(String orderId) {
    _orderRepository.delete(orderId);
  }
}

final orderControllerProvider = Provider.autoDispose((ref) {
  final currentUser = ref.watch(currentUserProvider).value;

  return OrderController(ref: ref, currentUser: currentUser);
});

final currentOrderProvider = FutureProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrder;
});

final getOrderByUserProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.getOrdersByUser();
});
