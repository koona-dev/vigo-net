import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  List<Object?> get props => [
        productId,
        qty,
        price,
      ];
}

class Orders extends Equatable {
  final String? id;
  final String userId;
  final List<Cart> cartItems;
  final DateTime tanggalOrder;
  final String jenisPelayanan;
  final String status;

  const Orders({
    this.id,
    required this.userId,
    required this.cartItems,
    required this.tanggalOrder,
    required this.jenisPelayanan,
    required this.status,
  });

  factory Orders.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Orders(
      id: id,
      userId: data['userId'] ?? '',
      cartItems: data['cartItems'] ?? [],
      tanggalOrder: data['tanggalOrder'] ?? DateTime.now(),
      jenisPelayanan: data['jenisPelayanan'] ?? '',
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cartItems': FieldValue.arrayUnion(cartItems),
      'tanggalOrder': Timestamp.fromDate(tanggalOrder),
      'jenisPelayanan': jenisPelayanan,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        cartItems,
        tanggalOrder,
        jenisPelayanan,
        status,
      ];
}

class CheckoutNote extends Equatable {
  final String nama;
  final String noHp;
  final String alamat;
  final List<Cart> products;
  final int totalHarga;

  const CheckoutNote({
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.products,
    required this.totalHarga,
  });

  @override
  List<Object?> get props => [
        nama,
        noHp,
        alamat,
        products,
        totalHarga,
      ];
}
