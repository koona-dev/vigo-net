import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vigo_net_mobile/features/billing/domain/payment.dart';

class PaymentRepository {
  final _firestore = FirebaseFirestore.instance;
  // final _authString = "SB-Mid-server-m5hByDg5YQ_jdrKKnn8rJYz7:";

  Future<void> create(Payment payment) async {
    try {
      await _firestore.collection('payment').doc().set(payment.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Payment?> findOne({String? docId, Query? filter}) async {
    if (docId != null) {
      return await _firestore
          .collection('payment')
          .doc(docId)
          .get()
          .then((doc) {
        return Payment.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      });
    }

    return await filter?.limit(1).get().then((QuerySnapshot querySnapshot) {
      final doc = querySnapshot.docs.first;
      return Payment.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Future<void> update(Payment payment) async {
    try {
      await _firestore.collection('payment').doc().set(payment.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  void delete(String paymentId) {
    _firestore.collection('payment').doc(paymentId).delete();
  }
}
