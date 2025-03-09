import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/catalog_product/domain/product.dart';

class ProductRepository {
  Future<List<Internet>> findAllInternet(Query filter) async {
    return await filter.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Internet.fromMap(
            id: doc.id, data: doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<Addons>> findAllAddons(Query filter) async {
    return await filter.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Addons.fromMap(
            id: doc.id, data: doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
