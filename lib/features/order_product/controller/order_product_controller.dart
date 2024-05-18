import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/auth/controller/auth_controller.dart';
import 'package:isp_app/features/order_product/repository/order_product_repository.dart';
import 'package:isp_app/model/order.dart';

enum ProductType { internet, addons }

// Finally, we are using ChangeNotifierProvider to allow the UI to interact with
// our CartNotifier class.
final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});

final orderControllerProvider = Provider((ref) {
  final orderRepository = ref.watch(orderProductRepoProvider);
  return OrderProductController(
    orderProductRepository: orderRepository,
    ref: ref,
  );
});

class CartNotifier extends ChangeNotifier {
  final List<Cart> _cartItems = [];
  List<Cart> get cartItems => _cartItems;

  int getQtyProduct(String productId) {
    notifyListeners();

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

  // Let's allow the UI to add _cartItems.
  void selectInternet({
    required String internetId,
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
    required int price,
  }) {
    final newAddons = Cart(
      productId: addonsId,
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

  void createOrder() {
    final currentUser = ref.watch(userDataAuthProvider).value;
    final cartData = ref.watch(cartProvider);

    orderProductRepository.insertOrderProduct(
      cartItems: cartData.cartItems,
      userId: currentUser!.id!,
      tanggalOrder: DateTime.now(),
      jenisPelayanan: 'Pemesanan Paket',
      status: 'on-progress',
    );
  }

  Future<CheckoutNote> showNote() {
    final currentUser = ref.watch(userDataAuthProvider).value;
    final cartData = ref.watch(cartProvider);

    return orderProductRepository.getOrderData(
      user: currentUser!,
      cartNotifier: cartData,
    );
  }
}
