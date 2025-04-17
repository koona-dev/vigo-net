import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:isp_app/features/billing/domain/billing.dart';
import 'package:isp_app/features/billing/domain/payment.dart';
import 'package:isp_app/features/user_management/domain/customer.dart';

class BillingRepository {
  final _firestore = FirebaseFirestore.instance;
  final _authString = "SB-Mid-server-m5hByDg5YQ_jdrKKnn8rJYz7:";

  Future<Map<String, dynamic>> createVAPayment({
    required Customer customer,
    required Billing billing,
    required Payment payment,
    required String bankName,
    required String vaNumber,
  }) async {
    var url =
        Uri.parse("https://app.sandbox.midtrans.com/snap/v1/transactions");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "transaction_details": {
            "order_id": billing.orderId,
            "gross_amount": billing.totalBill, // Amount in IDR
          },
          "customer_details": {
            "first_name": customer.user.username,
            "last_name": customer.user.name,
            "email": customer.user.email,
            "phone": customer.user.phone,
          },
          "payment_type": payment.paymentType,
          "bank_transfer": {
            "bank": bankName,
            "va_number": vaNumber, // Replace with the actual VA number
          }
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus(String orderId) async {
    var url = Uri.parse("https://api.sandbox.midtrans.com/v2/$orderId/status");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
          "Content-Type": "application/json",
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insert(Billing billing) async {
    try {
      await _firestore.collection('billing').doc().set(billing.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Billing?> findOne({String? docId, Query? filter}) async {
    if (docId != null) {
      return await _firestore
          .collection('billing')
          .doc(docId)
          .get()
          .then((doc) {
        return Billing.fromMap(
            {'id': doc.id, ...doc.data() as Map<String, dynamic>});
      });
    }

    return await filter?.limit(1).get().then((QuerySnapshot querySnapshot) {
      final doc = querySnapshot.docs.first;
      return Billing.fromMap(
          {'id': doc.id, ...doc.data() as Map<String, dynamic>});
    });
  }

  Stream<List<Billing>> findMany(Query filter) {
    return filter.snapshots().map(
          (collection) => collection.docs.map(
            (doc) {
              return Billing.fromMap(
                  {'id': doc.id, ...doc.data() as Map<String, dynamic>});
            },
          ).toList(),
        );
  }
}
