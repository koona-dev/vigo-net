import 'package:equatable/equatable.dart';
import 'package:isp_app/common/constants/product_type.dart';

enum JenisPemesanan { pasangBaru, tambahAddons, upgradePaket }

enum OrderStatus { menunggu, berhasil, dibatalkan }

class Cart extends Equatable {
  final String productId;
  final String productName;
  int qty;
  final int price;
  final ProductType productType;

  Cart({
    required this.productId,
    required this.productName,
    this.qty = 0,
    this.price = 0,
    required this.productType,
  });

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      qty: data['qty'] ?? 0,
      price: data['price'] ?? 0,
      productType: ProductType.values
          .firstWhere((element) => element.name == data['productType']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'qty': qty,
      'price': price,
      'productType': productType.name,
    };
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        qty,
        price,
      ];
}
