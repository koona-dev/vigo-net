import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogProductView extends ConsumerStatefulWidget {
  static const routeName = '/products';

  @override
  ConsumerState<CatalogProductView> createState() => _CatalogProductViewState();
}

class _CatalogProductViewState extends ConsumerState<CatalogProductView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
