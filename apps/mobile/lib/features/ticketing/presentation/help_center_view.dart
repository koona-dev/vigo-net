import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpCenterView extends ConsumerStatefulWidget {
  const HelpCenterView({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  ConsumerState<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends ConsumerState<HelpCenterView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
