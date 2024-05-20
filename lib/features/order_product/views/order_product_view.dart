import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/features/order_product/controller/order_product_controller.dart';

class OrderProductView extends ConsumerStatefulWidget {
  static const routeName = '/my-order';

  @override
  ConsumerState<OrderProductView> createState() => _OrderProductViewState();
}

class _OrderProductViewState extends ConsumerState<OrderProductView> {
  @override
  Widget build(BuildContext context) {
    final orderData = ref.watch(orderDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pemesanan'),
      ),
      body: orderData.when(
        data: (data) {
          final internet = data.products
              .firstWhere((cart) => cart.productType == ProductType.internet);
          final addons = data.products
              .where((cart) => cart.productType == ProductType.internet);

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nama'),
                  SizedBox(width: 20),
                  Text(data.nama),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nomor Handphone'),
                  SizedBox(width: 20),
                  Text(data.noHp),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alamat'),
                  SizedBox(width: 20),
                  Text(data.alamat),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text('Internet'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(child: Text(internet.productName)),
                      SizedBox(width: 20),
                      Text(internet.qty.toString()),
                      SizedBox(width: 20),
                      Text(internet.price.toString()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Addons'),
                  SizedBox(height: 8),
                  Column(
                    children: addons
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Flexible(child: Text(item.productName)),
                                SizedBox(width: 20),
                                Text(item.qty.toString()),
                                SizedBox(width: 20),
                                Text(item.price.toString()),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Harga'),
                  SizedBox(width: 20),
                  Text(data.totalHarga.toString()),
                ],
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                child: Text('Checkout'),
              ),
            ],
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => ErrorView(
          error: error.toString(),
        ),
      ),
    );
  }
}
