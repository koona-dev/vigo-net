import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/orders/order_controller.dart';
import 'package:isp_app/backend/user/user_controller.dart';
import 'package:isp_app/common/widgets/error.dart';
import 'package:isp_app/ui/orders/order_details_view.dart';
import 'package:isp_app/ui/products/product_view.dart';
import 'package:isp_app/ui/profile/user_information_view.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  Widget _showActivity(order) {
    return ListTile(
      tileColor: Colors.indigo.shade700,
      title: Text(
        'Pesanan Anda Berhasil di Verdifikasi',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Ticket pemesanan Anda berlaku sampai 20 maret 2024',
        style: TextStyle(color: Colors.white),
      ),
      trailing: Icon(
        Icons.navigate_next_sharp,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          OrderDetailsView.routeName,
          arguments: order,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).value!;
    final currentOrder = ref.watch(currentOrderProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentOrder.when(
            data: (data) => data != null
                ? _showActivity(data)
                : Card(
                    margin: EdgeInsets.all(24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Text(
                              'Koneksikan Duniamu dengan Kecepatan Tanpa Batas!'),
                          Text(
                              'Kini internet cepat bisa dibeli mulai harga Rp. 199.000/bulan'),
                          ElevatedButton(
                            onPressed: () {
                              if (user.address == null) {
                                Navigator.pushNamed(
                                    context, UserInformationView.routeName);
                              } else {
                                Navigator.pushNamed(
                                    context, ProductView.routeName);
                              }
                            },
                            child: Text('Pilih Paket Internet'),
                          ),
                        ],
                      ),
                    ),
                  ),
            error: (error, stackTrace) {
              return ErrorView(error: error.toString());
            },
            loading: () => CircularProgressIndicator(),
          ),
          SizedBox(height: 24),
          user.address == null
              ? ListTile(
                  title: Text('Silahkan Lengkapi Data Diri Anda'),
                  subtitle: Text('Kelengkapan profil Anda 60%'),
                  trailing: Icon(Icons.navigate_next_sharp),
                  onTap: () {
                    Navigator.pushNamed(context, UserInformationView.routeName);
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
