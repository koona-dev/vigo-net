import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:isp_app/features/ticketing/domain/ticket_status.dart';
import 'package:isp_app/features/order_internet/domain/cart.dart';
import 'package:isp_app/features/order_internet/domain/types.dart';

class Orders extends Equatable {
  final String? id;
  final String userId;
  final List<Cart> cartItems;
  final DateTime tanggalOrder;
  final JenisPemesanan jenisPemesanan;
  final TicketStatus status;
  final int totalHarga;
  final int? masaBerlakuPaket;

  const Orders({
    this.id,
    required this.userId,
    required this.cartItems,
    required this.tanggalOrder,
    this.jenisPemesanan = JenisPemesanan.pasangBaru,
    this.status = TicketStatus.menunggu,
    required this.totalHarga,
    this.masaBerlakuPaket,
  });

  factory Orders.fromMap({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return Orders(
      id: id,
      userId: data['userId'] ?? '',
      cartItems:
          data['cartItems'].map<Cart>((cart) => Cart.fromMap(cart)).toList(),
      tanggalOrder: (data['tanggalOrder'] as Timestamp).toDate(),
      jenisPemesanan: JenisPemesanan.values
          .firstWhere((element) => element.name == data['jenisPemesanan']),
      status: TicketStatus.values
          .firstWhere((element) => element.name == data['status']),
      totalHarga: data['totalHarga'] ?? 0,
      masaBerlakuPaket: data['masaBerlakuPaket'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    final cartItemsMap = cartItems.map((cart) => cart.toMap()).toList();
    return {
      'userId': userId,
      'cartItems': FieldValue.arrayUnion(cartItemsMap),
      'tanggalOrder': Timestamp.fromDate(tanggalOrder),
      'jenisPemesanan': jenisPemesanan.name,
      'status': status.name,
      'totalHarga': totalHarga,
      'masaBerlakuPaket': masaBerlakuPaket,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        cartItems,
        tanggalOrder,
        jenisPemesanan.name,
        status.name,
        totalHarga,
        masaBerlakuPaket
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
