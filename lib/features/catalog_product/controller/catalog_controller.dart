import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/features/catalog_product/repository/catalog_repository.dart';
import 'package:isp_app/model/product.dart';

final catalogDataAuthProvider = FutureProvider((ref) {
  final catalogRepository = ref.watch(catalogRepoProvider);
  final catalogController = CatalogController(catalogRepository);
  return catalogController.displayAllProduct();
});

class CatalogController {
  final CatalogRepository catalogRepository;
  CatalogController(this.catalogRepository);

  Future<Catalog> displayAllProduct() async {
    return await catalogRepository.getAllProduct();
  }
}
