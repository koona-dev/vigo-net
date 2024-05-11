import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/order.dart';

class CartNotifier extends ChangeNotifier {
  final cart = Cart();
  int getQtyAddons(String addonsId) {
    if (cart.addons.isEmpty) {
      return 0;
    } else {
      final addons = cart.addons.firstWhere((addons) {
        return addons.id == addonsId;
      });

      return addons.qty;
    }
  }

  int get totalQtyAddons =>
      cart.addons.fold(0, (sum, addons) => sum + addons.qty);

  // int get subTotalPrice {
  //   final totalAddonsPrice =
  //       cart.addons.fold(0, (sum, addons) => sum + addons.qty * addons.price);
  //   final internetPrice = cart.internetId != null;
  // }

  // Let's allow the UI to add cart.
  void selectInternet(String internetId) {
    if (internetId == cart.internetId) {
      cart.internetId = null;
    } else {
      cart.internetId = internetId;
    }
    notifyListeners();
  }

  void addAddons(String addonsId) {
    final newAddons = AddonsCart(
      id: addonsId,
      qty: 1,
    );

    cart.addons.forEach((addons) {
      if (addonsId == addons.id) {
        addons.qty++;
      } else {
        cart.addons.add(newAddons);
      }
    });

    notifyListeners();
  }

  // Let's allow removing cart
  void removeAddons(String addonsId) {
    cart.addons.forEach((addons) {
      if (addonsId == addons.id) {
        addons.qty--;
      }
    });

    notifyListeners();
  }
}

// Finally, we are using ChangeNotifierProvider to allow the UI to interact with
// our CartNotifier class.
final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});
