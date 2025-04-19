import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/core/conststans/product_type.dart';
import 'package:isp_app/features/order_internet/domain/cart.dart';
import 'package:isp_app/features/order_internet/domain/checkout.dart';
import 'package:isp_app/features/user_management/domain/user.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

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

final cartProvider = ChangeNotifierProvider.autoDispose<CartNotifier>((ref) {
  final currentUser = ref.watch(userDataProvider).value;
  return CartNotifier(currentUser!);
});
