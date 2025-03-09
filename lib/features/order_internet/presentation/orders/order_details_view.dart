import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isp_app/core/conststans/product_type.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  final Orders order;

  const OrderDetailsView({
    Key? key,
    required this.order,
  }) : super(key: key);

  static const routeName = '/order-details';

  @override
  ConsumerState<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    final internet = widget.order.cartItems.firstWhere(
      (element) => element.productType == ProductType.internet,
    );
    final addonsPrice = widget.order.cartItems.fold(0, (total, item) {
      if (item.productType == ProductType.addons) {
        return total + item.price;
      }
      return total;
    });
    final orderDate = DateFormat.yMMMd().format(widget.order.tanggalOrder);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rincian Pemesanan'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(internet.productName),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.order.id!),
                SizedBox(width: 20),
                Text(widget.order.jenisPemesanan.name),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderDate),
                SizedBox(width: 20),
                Text(widget.order.status.name),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.order.id!),
                SizedBox(width: 20),
                Text(widget.order.jenisPemesanan.name),
              ],
            ),
            SizedBox(height: 12),
            Text('Biaya Pemesanan'),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Paket WNG'),
                SizedBox(width: 20),
                Text(internet.price.toString()),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sewa Perangkat'),
                SizedBox(width: 20),
                Text(addonsPrice.toString()),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pembayaran'),
                SizedBox(width: 20),
                Text(widget.order.totalHarga.toString()),
              ],
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            Text('Status Pemasangan'),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.done, size: 24),
                SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Registrasi Pelanggan Baru'),
                      SizedBox(height: 8),
                      Text(
                          'Berhasil Menyetujui kontrak. Admin menentukan teknisi dan jadwal pemasangan'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
