import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:isp_app/core/conststans/product_type.dart';

import 'package:isp_app/features/billing/domain/billing.dart';
import 'package:isp_app/features/billing/domain/payment.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/user_management/domain/user.dart';

class BillingRepository {
  final _firestore = FirebaseFirestore.instance;
  // final _authString = "SB-Mid-server-m5hByDg5YQ_jdrKKnn8rJYz7:";

  Future<Map<String, dynamic>> createVAPayment({
    required AuthUser user,
    required Orders order,
    required Billing billing,
    required Payment payment,
  }) async {
    final url = Uri.parse("localhostt:8080/api/billing/create-va");

    try {
      final internetItem = order.cartItems
          .firstWhere((element) => element.productType == ProductType.internet);

      final response = await http.post(
        url,
        headers: {
          // "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "transaction_details": {
            "order_id": billing.invoiceNumber,
            "gross_amount": billing.totalBill, // Amount in IDR
          },
          "item_details": [
            {
              "id": internetItem.productType,
              "name": internetItem.productName,
              "quantity": internetItem.qty,
              "price": internetItem.price,
            }
          ],
          "customer_details": {
            "first_name": user.username,
            "last_name": user.name,
            "email": user.email,
            "phone": user.phone,
          },
          "payment_type": payment.paymentType,
          // "bank_transfer": {
          //   "bank": payment.activeVaBank.name,
          //   "va_number": payment.vaBank.selectBank(billing
          //       .payment.activeVaBank), // Replace with the actual VA number
          // },
          "enabled_payments": [
            "gopay",
            "bca_va",
            "bni_va",
            "bri_va",
            "echannel",
            "Indomaret",
            "alfamart",
          ],
          "bca_va": {
            "va_number": payment.vaBank.bca,
          },
          "bni_va": {"va_number": payment.vaBank.bni},
          "bri_va": {"va_number": payment.vaBank.bri},
          "expiry": {
            "start_time": billing.tanggalTagihan.toDate().toString(),
            "unit": "days",
            "duration": 7
          },
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus(String invoiceNumber) async {
    final url =
        Uri.parse("localhostt:8080/api/billing/check-payment/$invoiceNumber");

    try {
      final response = await http.get(
        url,
        headers: {
          // "Authorization": "Basic " + base64Encode(utf8.encode(_authString)),
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

  Future<Billing> findOne({String? docId, Query? filter}) async {
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

    return await filter!.limit(1).get().then((QuerySnapshot querySnapshot) {
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
