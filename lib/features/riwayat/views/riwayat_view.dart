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
  }
}
