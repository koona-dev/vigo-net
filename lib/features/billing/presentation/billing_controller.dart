import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/billing/data/billing_repository.dart';
import 'package:isp_app/features/billing/domain/billing.dart';
import 'package:isp_app/features/billing/domain/billing_status.dart';
import 'package:isp_app/features/billing/domain/payment.dart';
import 'package:isp_app/features/order_internet/data/order_repository.dart';
import 'package:isp_app/features/order_internet/domain/order.dart';
import 'package:isp_app/features/order_internet/domain/types.dart';
import 'package:isp_app/features/order_internet/presentation/cart_controller.dart';
import 'package:isp_app/features/user_management/domain/customer.dart';
import 'package:isp_app/features/user_management/domain/types.dart';
import 'package:isp_app/features/user_management/domain/user.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

class BillingController {
  final _billingRepository = BillingRepository();

  Stream<Billing?> currentPendingBilling() {
    final filter = getFilteredQuery('billing', {
      'customerId': {
        'isEqualTo': currentUser?.id,
      },
      'status': {
        'isEqualTo': BillingStatus.belumBayar,
      },
    });
    return _billingRepository.findOne(filter: filter);
  }

  void payBill({
    required Customer customer,
    required Billing billing,
    required MitraBank bank,
  }) async {
    final payment = Payment(
      orderId: billing.orderId,
      grossAmount: billing.totalBill,
      customer: customer,
      paymentType: "bank_transfer",
      bankName: bank,
    );

    try {
      await _billingRepository.createVAPayment(payment);
      await _billingRepository.insert(billing);
    } catch (e) {
      rethrow;
    }
  }
}

final orderControllerProvider = Provider.autoDispose((ref) {
  final currentUser = ref.watch(userDataProvider).value;

  return BillingController(ref: ref, currentUser: currentUser);
});

final currentOrderPemasanganProvider = FutureProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrderPemasangan;
});

final currentOrderDetailsProvider =
    FutureProvider.family.autoDispose((ref, String docId) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.currentOrderDetails(docId);
});

final getOrderByUserProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider);
  return orderController.getOrdersByUser();
});
