import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/products/product.dart';
import 'package:isp_app/backend/products/product_repository.dart';

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
