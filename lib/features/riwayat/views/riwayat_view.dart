import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/features/order_product/controller/order_product_controller.dart';

class RiwayatView extends ConsumerStatefulWidget {
  const RiwayatView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends ConsumerState<RiwayatView> {
  @override
  Widget build(BuildContext context) {
    final ordersData = ref.watch(orderDataProvider);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Tagihan'),
              Tab(text: 'Permintaan'),
              Tab(text: 'Pemesanan'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: Text('Ini listview Tagihan'),
                ),
                Center(
                  child: Text('Ini listview Permintaan'),
                ),
                ordersData.when(
                  data: (data) {
                    return ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final order = data[index]!;
                        final item = order.cartItems.firstWhere(
                          (element) =>
                              element.productType == ProductType.internet,
                        );
                        final orderDate =
                            DateFormat.yMMMd().format(order.tanggalOrder);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Chip(
                                  label: Text('Menunggu'),
                                  backgroundColor: Colors.yellow,
                                ),
                                SizedBox(height: 12),
                                Text(item.productName),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(order.id!),
                                    SizedBox(width: 20),
                                    Text(orderDate.toString()),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(order.totalHarga.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) => ErrorView(
                    error: error.toString(),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
