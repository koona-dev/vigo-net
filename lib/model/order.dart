import 'package:equatable/equatable.dart';
import 'package:isp_app/features/order_product/controller/order_product_controller.dart';

class Cart extends Equatable {
  final String? productId;
  int qty;
  final int price;
  final ProductType? productType;

  Cart({
    this.productId,
    this.qty = 0,
    this.price = 0,
    this.productType,
  });

  void incrementQuantity() {
    qty++;
  }

  // Method untuk mengurangi jumlah item
  void decrementQuantity() {
    if (qty > 0) {
      qty--;
    }
  }

  @override
  List<Object?> get props => [
        productId,
        qty,
        price,
      ];
}
