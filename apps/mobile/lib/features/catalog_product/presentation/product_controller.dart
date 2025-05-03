import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigo_net_mobile/core/utils/firestore_filter.dart';
import 'package:vigo_net_mobile/features/catalog_product/data/product_repository.dart';
import 'package:vigo_net_mobile/features/catalog_product/domain/product.dart';

final productDataProvider = FutureProvider.autoDispose((ref) {
  final productController = ProductController();
  return productController.displayAllProduct();
});

class ProductController {
  final ProductRepository _productRepository = ProductRepository();

  Future<Product> displayAllProduct() async {
    try {
      final internetTableQuery = getFilteredQuery('internet', {});
      final addonsTableQuery = getFilteredQuery('addons', {});
      final internetData =
          await _productRepository.findAllInternet(internetTableQuery);
      final addonsData =
          await _productRepository.findAllAddons(addonsTableQuery);

      return Product(
        internetData: internetData,
        addonsData: addonsData,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
