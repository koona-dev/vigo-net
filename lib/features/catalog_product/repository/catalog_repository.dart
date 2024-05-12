import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/product.dart';

final catalogRepoProvider = Provider(
  (ref) => CatalogRepository(FirebaseFirestore.instance),
);

class CatalogRepository {
  final FirebaseFirestore firestore;
  CatalogRepository(this.firestore);

  Future<Catalog> getAllProduct() async {
    final internetData = await _getAllPaketInternet();
    final addonsData = await _getAllAddons();
    return Catalog(
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
