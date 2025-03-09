import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isp_app/core/conststans/product_type.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/order_internet/presentation/order_controller.dart';
import 'package:isp_app/features/order_internet/presentation/orders/order_details_view.dart';
import 'package:isp_app/shared/widgets/error.dart';
import 'package:isp_app/features/ticketing/domain/ticket_status.dart';

class HistoryView extends ConsumerStatefulWidget {
  @override
  ConsumerState<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  Widget _generatedStatusWidget(Orders order) {
    Widget _pendingStatusWidget = Chip(
      label: Text('Menunggu'),
      backgroundColor: Colors.yellow,
    );

    Widget _successStatusWidget = Chip(
      label: Text('Berhasil'),
      backgroundColor: Colors.green,
    );

    Widget _cancelStatusWidget = Chip(
      label: Text('Dibatalkan'),
      backgroundColor: Colors.red,
    );

    switch (order.status) {
      case TicketStatus.menunggu:
        return _pendingStatusWidget;
      case TicketStatus.berhasil:
        return _successStatusWidget;
      default:
        return _cancelStatusWidget;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = ref.watch(getOrderByUserProvider);

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

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              OrderDetailsView.routeName,
                              arguments: order,
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _generatedStatusWidget(order),
                                  SizedBox(height: 12),
                                  Text(item.productName),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(orderDate.toString()),
                                      SizedBox(width: 20),
                                      Text(order.totalHarga.toString()),
                                    ],
                                  ),
                                ],
                              ),
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
