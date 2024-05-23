import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/auth/controller/auth_controller.dart';
import 'package:isp_app/features/order_product/repository/order_product_repository.dart';
import 'package:isp_app/model/auth_user.dart';
import 'package:isp_app/model/order.dart';

enum ProductType { internet, addons }

final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  final currentUser = ref.watch(userDataAuthProvider).value;
  return CartNotifier(currentUser!);
});

final orderControllerProvider = Provider((ref) {
  final orderRepository = ref.watch(orderProductRepoProvider);
  return OrderProductController(
    orderProductRepository: orderRepository,
    ref: ref,
  );
});

final orderDataProvider = StreamProvider((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.displayDataOrder();
});

final orderStatusProvider = FutureProvider((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.isOrder;
});

class CartNotifier extends ChangeNotifier {
  final AuthUser currentUser;
  CartNotifier(this.currentUser);

  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  int getQtyProduct(String productId) {
    if (_cartItems.isNotEmpty &&
        _cartItems.any((element) => element.productId == productId)) {
      final cart =
          _cartItems.firstWhere((element) => element.productId == productId);
      return cart.qty;
    } else {
      return 0;
    }
  }

  int get totalQtyProduct =>
      _cartItems.fold(0, (sum, product) => sum + product.qty);

  int get subTotalPrice {
    final totalPrice = _cartItems.fold(
      0,
      (sum, product) => sum + product.qty * product.price,
    );
    return totalPrice;
  }

  Cart? currentItems(String productId) {
    if (_cartItems.any((element) => element.productId == productId)) {
      return _cartItems.firstWhere((element) => element.productId == productId);
    } else {
      return null;
    }
  }

  CheckoutNote get showNote {
    final note = CheckoutNote(
      nama: currentUser.name!,
      noHp: currentUser.phone!,
      alamat: currentUser.address!,
      products: cartItems,
      totalHarga: subTotalPrice,
    );

    return note;
  }

  // Let's allow the UI to add _cartItems.
  void selectInternet({
    required String internetId,
    required String internetName,
    required int price,
  }) {
    final cartIdx =
        _cartItems.indexWhere((element) => element.productId == internetId);

    if (cartIdx < 0) {
      _cartItems.removeWhere(
          (element) => element.productType == ProductType.internet);

      _cartItems.add(
        Cart(
          productId: internetId,
          productName: internetName,
          qty: 1,
          price: price,
          productType: ProductType.internet,
        ),
      );
    } else {
      _cartItems.removeAt(cartIdx);
    }
    notifyListeners();
  }

  void addAddons({
    required String addonsId,
    required String addonsName,
    required int price,
  }) {
    final newAddons = Cart(
      productId: addonsId,
      productName: addonsName,
      qty: 1,
      price: price,
      productType: ProductType.addons,
    );

    if (_cartItems.isNotEmpty &&
        _cartItems.any((element) => element.productId == addonsId)) {
      final cart =
          _cartItems.firstWhere((element) => element.productId == addonsId);
      cart.qty++;
    } else {
      _cartItems.add(newAddons);
    }

    notifyListeners();
  }

  // Let's allow removing _cartItems
  void removeAddons(String addonsId) {
    for (var cart in _cartItems) {
      if (addonsId == cart.productId) {
        if (cart.qty > 0) {
          cart.qty--;
        } else {
          _cartItems.remove(cart);
        }
      }
    }

    notifyListeners();
  }
}

class OrderProductController {
  final OrderProductRepository orderProductRepository;
  final ProviderRef ref;
  OrderProductController({
    required this.orderProductRepository,
    required this.ref,
  });

  Future<bool> get isOrder {
    final currentUser = ref.watch(userDataAuthProvider).value;
    final userId = currentUser!.id!;
    return orderProductRepository.isOrderPasangBaru(userId);
  }

  void createOrder() {
    final currentUser = ref.watch(userDataAuthProvider).value;
    final cartData = ref.watch(cartProvider);

    orderProductRepository.insertOrderProduct(
      cartItems: cartData.cartItems,
      userId: currentUser!.id!,
      tanggalOrder: DateTime.now(),
      status: 'on-progress',
    );

    ref.watch(authControllerProvider).editProfile({'role': 'cp'});
  }

  Stream<List<Orders?>> displayDataOrder() {
    final currentUser = ref.watch(userDataAuthProvider).value;
    return orderProductRepository.getOrdersByUser(currentUser!.id!);
  }

  void cancelOrder(String orderId) {
    orderProductRepository.deleteOrder(orderId);
  }
}
