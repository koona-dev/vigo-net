import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/backend/products/product.dart';

final productRepoProvider = Provider(
  (ref) => ProductRepository(FirebaseFirestore.instance),
);

class ProductRepository {
  final FirebaseFirestore firestore;
  ProductRepository(this.firestore);

  Future<Product> getAllProduct() async {
    final internetData = await _getAllPaketInternet();
    final addonsData = await _getAllAddons();
    return Product(
      internetData: internetData,
      addonsData: addonsData,
    );
  }

  Future<List<Internet>> _getAllPaketInternet() async {
    late List<Internet> internetData;

    final internetFromDB = await firestore.collection('internet').get();
    final dataMap = internetFromDB.docs.map((item) {
      return Internet.fromMap(id: item.id, data: item.data());
    }).toList();
    internetData = List.from(dataMap);

    return internetData;
  }

  Future<List<Addons>> _getAllAddons() async {
    late List<Addons> addonsData;

    final internetFromDB = await firestore.collection('addons').get();
    final dataMap = internetFromDB.docs.map((item) {
      return Addons.fromMap(id: item.id, data: item.data());
    }).toList();
    addonsData = List.from(dataMap);

    return addonsData;
  }
}
