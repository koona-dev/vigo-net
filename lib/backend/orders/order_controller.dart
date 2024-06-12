import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/cart/cart_controller.dart';
import 'package:isp_app/backend/orders/order.dart';
import 'package:isp_app/backend/orders/order_repository.dart';
import 'package:isp_app/backend/user/user_controller.dart';

final orderControllerProvider = Provider((ref) {
  final orderRepository = ref.watch(orderRepoProvider);
  return OrderController(
    orderRepository: orderRepository,
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
  final OrderRepository orderRepository;
  final ProviderRef ref;
  OrderController({
    required this.orderRepository,
    required this.ref,
  });

  Future<Orders?> get currentOrder {
    final currentUser = ref.watch(userDataProvider).value;
    final userId = currentUser!.id!;
    return orderRepository.currentOrder(userId);
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
