import 'package:equatable/equatable.dart';
import 'package:isp_app/backend/cart/cart.dart';

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
