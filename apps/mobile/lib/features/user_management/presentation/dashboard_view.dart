import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth/login_view.dart';
import 'package:vigo_net_mobile/features/authentication/presentation/auth_controller.dart';
import 'package:vigo_net_mobile/features/catalog_product/presentation/products/product_view.dart';
import 'package:vigo_net_mobile/features/order_internet/domain/order.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/order_controller.dart';
import 'package:vigo_net_mobile/features/order_internet/presentation/orders/order_details_view.dart';
import 'package:vigo_net_mobile/features/ticketing/presentation/ticketing_controller.dart';
import 'package:vigo_net_mobile/features/user_management/domain/user.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/profile/user_information_view.dart';
import 'package:vigo_net_mobile/features/user_management/presentation/user_controller.dart';
import 'package:vigo_net_mobile/shared/widgets/error.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  Widget _showActivity(AuthUser user, Orders order) {
    final currentTicket =
        ref.watch(findOneTicketOrderProvider(user.id!)).value!;

    print('CURRENT TICKET: ${currentTicket.activity}');

    return ListTile(
      tileColor: Colors.indigo.shade700,
      title: Text(
        currentTicket.activity.title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        currentTicket.activity.description,
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
    final currentOrder = ref.watch(currentOrderPemasanganProvider);

    print('USER: $user');
    print('CURRENT ORDER: $currentOrder');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentOrder.when(
            data: (data) => data != null
                ? _showActivity(user, data)
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
          FilledButton(
              onPressed: () {
                ref.read(authControllerProvider).signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginView.routeName, ModalRoute.withName('/'));
              },
              child: Text('Log out'))
        ],
      ),
    );
  }
}
