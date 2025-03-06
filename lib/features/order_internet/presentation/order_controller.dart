import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/order_internet/data/order_repository.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/order_internet/presentation/cart_controller.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

final orderControllerProvider = Provider((ref) {
  return OrderController(
    ref: ref,
  );
});

final orderDataProvider = StreamProvider((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.displayDataOrder();
});

final currentOrderProvider = FutureProvider((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrder;
});

class OrderController {
  final Ref ref;
  OrderController({
    required this.ref,
  });

  final orderRepository = OrderRepository();

  Future<Orders?> get currentOrder {
    final currentUser = ref.watch(userDataProvider).value;
    final userId = currentUser!.id;
    log('ID = $userId');
    return orderRepository.currentOrder(userId!);
  }

  void createOrder() {
    final currentUser = ref.watch(userDataProvider).value;
    final cartData = ref.watch(cartProvider);

    orderRepository.insertOrder(
      cartItems: cartData.cartItems,
      userId: currentUser!.id!,
      tanggalOrder: DateTime.now(),
      totalHarga: cartData.subTotalPrice,
    );

    ref.watch(userControllerProvider).editProfile({'role': 'cp'});
  }

  Stream<List<Orders?>> displayDataOrder() {
    final currentUser = ref.watch(userDataProvider).value;
    return orderRepository.getOrdersByUser(currentUser!.id!);
  }

  void cancelOrder(String orderId) {
    orderRepository.deleteOrder(orderId);
  }
}
