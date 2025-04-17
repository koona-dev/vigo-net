import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/core/conststans/product_type.dart';
import 'package:isp_app/features/catalog_product/presentation/product_controller.dart';
import 'package:isp_app/features/order_internet/presentation/cart_controller.dart';
import 'package:isp_app/features/order_internet/presentation/orders/order_view.dart';
import 'package:isp_app/shared/widgets/error.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  static const routeName = '/products';

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _openCartDialog(CartNotifier cartNotifier) {
    if (cartNotifier.cartItems != []) {
      scaffoldKey.currentState?.showBottomSheet(
        (context) => Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey),
            ),
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('qty : ${cartNotifier.totalQtyProduct}'),
                      const SizedBox(height: 8),
                      Text('Sub total : ${cartNotifier.subTotalPrice}'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  FilledButton(
                    onPressed: cartNotifier.cartItems.any((element) =>
                            element.productType == ProductType.internet)
                        ? () {
                            Navigator.pushNamed(
                              context,
                              OrderView.routeName,
                            );
                          }
                        : null,
                    child: const Text('Buy'),
                  ),
                ],
              ),
            ),
          ),
        ),
        enableDrag: false,
        elevation: 2,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.watch(cartProvider);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Menu Products'),
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TabBar(
              tabs: [
                Text('Paket Data'),
                Text('Addons'),
              ],
            ),
            Expanded(
              child: ref.watch(productDataProvider).when(
                    data: (catalog) {
                      final internetList = catalog.internetData;
                      final addonsList = catalog.addonsData;

                      return TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: internetList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          internetList[index].title!,
                                          softWrap: true,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Rp ${internetList[index].price!}/bulan'),
                                          const SizedBox(width: 20),
                                          FilledButton(
                                            onPressed: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .selectInternet(
                                                    internetId:
                                                        internetList[index].id!,
                                                    internetName:
                                                        internetList[index]
                                                            .title!,
                                                    price: internetList[index]
                                                        .price!,
                                                  );

                                              _openCartDialog(cartNotifier);
                                            },
                                            style: FilledButton.styleFrom(
                                                backgroundColor:
                                                    cartNotifier.currentItems(
                                                                internetList[
                                                                        index]
                                                                    .id!) ==
                                                            null
                                                        ? Colors.blueGrey[600]
                                                        : Colors.orange),
                                            child: const Text('BUY'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: addonsList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              'https://images.unsplash.com/photo-1606904825846-647eb07f5be2?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              addonsList[index].title!,
                                              softWrap: true,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    'Rp ${addonsList[index].price}/bulan'),
                                                const SizedBox(width: 20),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: cartNotifier
                                                                  .getQtyProduct(
                                                                      addonsList[
                                                                              index]
                                                                          .id!) !=
                                                              0
                                                          ? () {
                                                              ref
                                                                  .read(cartProvider
                                                                      .notifier)
                                                                  .removeAddons(
                                                                      addonsList[
                                                                              index]
                                                                          .id!);

                                                              _openCartDialog(
                                                                  cartNotifier);
                                                            }
                                                          : null,
                                                      icon: const Icon(
                                                          Icons.remove),
                                                    ),
                                                    Text(
                                                      cartNotifier
                                                          .getQtyProduct(
                                                              addonsList[index]
                                                                  .id!)
                                                          .toString(),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        ref
                                                            .read(cartProvider
                                                                .notifier)
                                                            .addAddons(
                                                              addonsId:
                                                                  addonsList[
                                                                          index]
                                                                      .id!,
                                                              addonsName:
                                                                  addonsList[
                                                                          index]
                                                                      .title!,
                                                              price: addonsList[
                                                                      index]
                                                                  .price!,
                                                            );

                                                        _openCartDialog(
                                                            cartNotifier);
                                                      },
                                                      icon:
                                                          const Icon(Icons.add),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    error: (err, trace) {
                      return ErrorView(error: err.toString());
                    },
                    loading: () => const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
