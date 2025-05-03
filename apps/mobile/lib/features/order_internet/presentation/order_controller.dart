import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vigo_net_mobile/core/utils/firestore_filter.dart';
import 'package:vigo_net_mobile/features/order_internet/data/order_repository.dart';
import 'package:vigo_net_mobile/features/order_internet/domain/order.dart';
import 'package:vigo_net_mobile/features/order_internet/domain/types.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/cart_controller.dart';
import 'package:vigo_net_mobile/features/user_management/domain/types.dart';
import 'package:vigo_net_mobile/features/user_management/domain/user.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/user_controller.dart';

class OrderController {
  final AuthUser? currentUser;
  final Ref ref;
  OrderController({required this.ref, this.currentUser});

  final _orderRepository = OrderRepository();

  Future<Orders?> get currentOrderPemasangan async {
    final filter = getFilteredQuery('orders', {
      'userId': {
        'isEqualTo': currentUser?.id,
      },
      'jenisPemesanan': {'isEqualTo': JenisPemesanan.pasangBaru.name},
    });
    return await _orderRepository.findOne(filter: filter);
  }

  Future<Orders?> currentOrderDetails(String docId) async {
    return await _orderRepository.findOne(docId: docId);
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
  final currentUser = ref.watch(userDataProvider).value;

  return OrderController(ref: ref, currentUser: currentUser);
});

final currentOrderPemasanganProvider = FutureProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrderPemasangan;
});

final currentOrderDetailsProvider =
    FutureProvider.family.autoDispose((ref, String docId) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrderDetails(docId);
});

final getOrderByUserProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.getOrdersByUser();
});
