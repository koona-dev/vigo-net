import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/auth/controller/auth_controller.dart';
import 'package:isp_app/features/catalog_product/views/catalog_product_view.dart';
import 'package:isp_app/features/order_product/controller/order_product_controller.dart';
import 'package:isp_app/features/profile/views/user_information_view.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  Widget _showActivity() {
    return ListTile(
      tileColor: Colors.indigo.shade700,
      title: Text('Pesanan Anda Berhasil di Verdifikasi'),
      subtitle: Text('Ticket pemesanan Anda berlaku sampai 20 maret 2024'),
      trailing: Icon(Icons.navigate_next_sharp),
      onTap: () {
        // Navigator.pushNamed(context, UserInformationView.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataAuthProvider).value!;
    final isOrder = ref.watch(orderStatusProvider);

    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/person.jpg'),
        ),
        title: Text('Stefan Steakin'),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isOrder.value!
              ? _showActivity()
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
                            Navigator.pushNamed(
                                context, CatalogProductView.routeName);
                          },
                          child: Text('Pilih Paket Internet'),
                        ),
                      ],
                    ),
                  ),
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
