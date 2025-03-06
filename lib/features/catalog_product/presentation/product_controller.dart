import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/catalog_product/data/product_repository.dart';
import 'package:isp_app/features/catalog_product/domain/product.dart';

final productDataProvider = FutureProvider((ref) {
  final productRepository = ref.watch(productRepoProvider);
  final productController = ProductController(productRepository);
  return productController.displayAllProduct();
});

class ProductController {
  final ProductRepository productRepository;
  ProductController(this.productRepository);

  Future<Product> displayAllProduct() async {
    return await productRepository.getAllProduct();
  }
}
