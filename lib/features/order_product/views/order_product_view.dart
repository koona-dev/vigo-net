import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderProductView extends ConsumerStatefulWidget {
  static const routeName = '/products';

  @override
  ConsumerState<OrderProductView> createState() => _OrderProductViewState();
}

class _OrderProductViewState extends ConsumerState<OrderProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pemesanan'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nama'),
              SizedBox(width: 20),
              Text(''),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nomor Handphone'),
              SizedBox(width: 20),
              Text(''),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Alamat'),
              SizedBox(width: 20),
              Text(''),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Internet'),
              SizedBox(width: 20),
              Text(''),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Addons'),
              SizedBox(width: 20),
              Text('qty'),
              SizedBox(width: 20),
              Text('')
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Harga'),
              SizedBox(width: 20),
              Text(''),
            ],
          ),
          SizedBox(height: 20),
          FilledButton(
            onPressed: () {},
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
