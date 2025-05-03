import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/core/conststans/product_type.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/cart_controller.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/order_controller.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity_states/activity_status.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity_states/instalation_wifi_state.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/category.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/ticket_status.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/ticketing.dart';
import 'package:vigo_net_mobile/features/ticketing/presentation/ticketing_controller.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/dashboard_view.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/user_controller.dart';

class OrderView extends ConsumerStatefulWidget {
  static const routeName = '/my-order';

  @override
  ConsumerState<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends ConsumerState<OrderView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).value!;
    final orderProvider = ref.watch(cartProvider);
    final orderData = orderProvider.showNote;
    final internet = orderData.products
        .firstWhere((cart) => cart.productType == ProductType.internet);
    final addons = orderData.products
        .where((cart) => cart.productType == ProductType.addons);

    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Pemesanan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama'),
                SizedBox(width: 20),
                Text(orderData.nama),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nomor Handphone'),
                SizedBox(width: 20),
                Text(orderData.noHp),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alamat'),
                SizedBox(width: 20),
                Text(orderData.alamat),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(orderData.totalHarga.toString()),
              ],
            ),
            SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                final ticket = Ticketing(
                  title: 'Order Sambung Baru',
                  activity: Activity(
                    title: 'Verifikasi Pemesanan',
                    description: 'Menunggu verifikasi',
                    status: ActivityStatus.menunggu,
                    flag: InstalationWifiState.verifikasiPemesanan.name,
                  ),
                  category: TicketCategory.pemesanan,
                  description: 'Sambung Baru',
                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(const Duration(days: 1)),
                  status: TicketStatus.menunggu,
                  userId: user.id!,
                );
                ref.read(orderControllerProvider).createOrder();
                ref.read(ticketingControllerProvider).createTicketing(ticket);
                Navigator.pushNamedAndRemoveUntil(
                    context, DashboardView.routeName, (route) => false);
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
