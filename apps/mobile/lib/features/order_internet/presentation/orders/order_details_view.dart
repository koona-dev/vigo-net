import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vigo_net_mobile/core/conststans/product_type.dart';
import 'package:vigo_net_mobile/features/order_internet/domain/order.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity_states/activity_status.dart';
import 'package:vigo_net_mobile/features/ticketing/domain/activity_states/instalation_wifi_state.dart';
import 'package:vigo_net_mobile/features/ticketing/presentation/ticketing_controller.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/user_controller.dart';

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
            _activityOrder(),
          ],
        ),
      ),
    );
  }

  Widget _activityOrder() {
    final user = ref.watch(userDataProvider).value!;
    final currentTicket = ref.watch(findOneTicketOrderProvider(user.id!)).value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  Text(currentTicket!.activity.title),
                  SizedBox(height: 8),
                  Text(currentTicket.activity.description),
                  currentTicket.activity.flag ==
                          InstalationWifiState.bayarInstalasi.name
                      ? FilledButton(
                          onPressed: () {
                            ref
                                .read(ticketingControllerProvider)
                                .updateActivityTicket(currentTicket.copyWith(
                                  activity: Activity(
                                    title: 'Pemasangan Berhasil',
                                    description:
                                        'Silahkan lakukan pembayaran instalasi',
                                    status: ActivityStatus.menunggu,
                                    flag: InstalationWifiState
                                        .bayarInstalasi.name,
                                  ),
                                ));
                          },
                          child: Text('Bayar Instalasi'),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
