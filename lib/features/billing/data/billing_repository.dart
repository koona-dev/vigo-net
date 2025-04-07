import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:isp_app/features/billing/domain/billing.dart';
import 'package:isp_app/features/billing/domain/payment.dart';

class BillingRepository {
  final _firestore = FirebaseFirestore.instance;
  final _authString = "SB-Mid-server-m5hByDg5YQ_jdrKKnn8rJYz7:";

  Future<void> createVAPayment(Payment payment) async {
    var url =
        Uri.parse("https://app.sandbox.midtrans.com/snap/v1/transactions");

    var response = await http.post(
      url,
      headers: {
        "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "transaction_details": {
          "order_id": payment.orderId,
          "gross_amount": payment.grossAmount, // Amount in IDR
        },
        "customer_details": {
          "first_name": payment.customer.user.username,
          "last_name": payment.customer.user.name,
          "email": payment.customer.user.email,
          "phone": payment.customer.user.phone,
        },
        "payment_type": payment.paymentType,
        "bank_transfer": {
          "bank": payment.bankName.name,
        }
      }),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print("Transaction Created: ${data['redirect_url']}");
    } else {
      print("Error: ${response.body}");
    }
  }

  Future<void> checkPaymentStatus(String orderId) async {
    var url = Uri.parse("https://api.sandbox.midtrans.com/v2/$orderId/status");

    var response = await http.get(
      url,
      headers: {
        "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Payment Status: ${data['transaction_status']}");
    } else {
      print("Error: ${response.body}");
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
