import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiwayatView extends ConsumerStatefulWidget {
  const RiwayatView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends ConsumerState<RiwayatView> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // DefaultTabController(
    //   length: 3,
    //   child: Column(
    //     children: [
    //       TabBar(
    //         tabs: [
    //           Tab(text: 'Tagihan'),
    //           Tab(text: 'Permintaan'),
    //           Tab(text: 'Pemesanan'),
    //         ],
    //       ),
    //       Expanded(
    //         child: TabBarView(
    //           children: [
    //             Center(
    //               child: Text('Ini listview Tagihan'),
    //             ),
    //             Center(
    //               child: Text('Ini listview Permintaan'),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
