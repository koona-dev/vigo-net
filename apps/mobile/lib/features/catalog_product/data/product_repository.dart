import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isp_app/features/catalog_product/domain/product.dart';

class ProductRepository {
  Future<Internet> getOneInternet(String docId) async {
    return await FirebaseFirestore.instance
        .collection('internet')
        .doc(docId)
        .get()
        .then((doc) {
      return Internet.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Future<Addons> getOneAddons(String docId) async {
    return await FirebaseFirestore.instance
        .collection('addons')
        .doc(docId)
        .get()
        .then((doc) {
      return Addons.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Future<List<Internet>> findAllInternet(Query filter) async {
    return await filter.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Internet.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      }).toList();
    });
  }

  Future<List<Addons>> findAllAddons(Query filter) async {
    return await filter.get().then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Addons.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      }).toList();
    });
  }
}
