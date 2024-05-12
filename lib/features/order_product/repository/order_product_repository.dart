import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProductRepoProvider = Provider(
  (ref) => OrderProductRepository(FirebaseFirestore.instance),
);

class OrderProductRepository {
  final FirebaseFirestore firestore;
  OrderProductRepository(this.firestore);
}
