import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/profile/views/user_information_view.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
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
          Card(
            margin: EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text('Koneksikan Duniamu dengan Kecepatan Tanpa Batas!'),
                  Text(
                      'Kini internet cepat bisa dibeli mulai harga Rp. 199.000/bulan'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Pilih Paket Internet'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          ListTile(
            title: Text('Silahkan Lengkapi Data Diri Anda'),
            subtitle: Text('Kelengkapan profil Anda 60%'),
            trailing: Icon(Icons.navigate_next_sharp),
            onTap: () {
              Navigator.pushNamed(context, UserInformationView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
