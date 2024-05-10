import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/model/order.dart';
import 'package:isp_app/model/product.dart';

final orderProductRepoProvider = Provider(
  (ref) => orderProductRepository(FirebaseFirestore.instance),
);

class orderProductRepository {
  final FirebaseFirestore firestore;
  orderProductRepository(this.firestore);

  Future<Cart> getAllProduct() async {
    final internetData = await _getAllPaketInternet();
    final addonsData = await _getAllAddons();
    return Cart();
  }

  Future<List<Internet>> _getAllPaketInternet() async {
    late List<Internet> internetData;

    final internetFromDB = await firestore.collection('internet').get();
    final dataMap = internetFromDB.docs.map((item) {
      return Internet.fromMap(item.data());
    }).toList();
    internetData = List.from(dataMap);

    return internetData;
  }

  Future<List<Addons>> _getAllAddons() async {
    late List<Addons> addonsData;

    final internetFromDB = await firestore.collection('addons').get();
    final dataMap = internetFromDB.docs.map((item) {
      return Addons.fromMap(item.data());
    }).toList();
    addonsData = List.from(dataMap);

    return addonsData;
  }
}
