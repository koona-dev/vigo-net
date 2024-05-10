import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/order.dart';

class CartNotifier extends ChangeNotifier {
  final cart = Cart();

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
