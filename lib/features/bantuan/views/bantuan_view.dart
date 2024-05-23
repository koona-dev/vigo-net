import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BantuanView extends ConsumerStatefulWidget {
  const BantuanView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<BantuanView> createState() => _BantuanViewState();
}

class _BantuanViewState extends ConsumerState<BantuanView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
