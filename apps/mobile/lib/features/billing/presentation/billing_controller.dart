import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isp_app/core/utils/firestore_filter.dart';
import 'package:isp_app/features/billing/data/billing_repository.dart';
import 'package:isp_app/features/billing/data/payment_repository.dart';
import 'package:isp_app/features/billing/domain/billing.dart';
import 'package:isp_app/features/billing/domain/payment.dart';
import 'package:isp_app/features/order_internet/data/order_repository.dart';
import 'package:isp_app/features/user_management/data/user_repository.dart';
import 'package:isp_app/features/user_management/domain/user.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

class BillingController {
  BillingController(Ref ref, {required this.currentUser});
  final AuthUser currentUser;

  final _userController = UserRepository();
  final _orderRepository = OrderRepository();
  final _billingRepository = BillingRepository();
  final _paymentRepository = PaymentRepository();

  Future<void> selectPaymentMethod({
    required VaBank vaBank,
    required SelectedBank activeBank,
  }) {
    final payment = Payment(
      customerId: currentUser.id!,
      paymentType: PaymentType.bankTransfer,
      vaBank: vaBank,
      activeVaBank: activeBank,
    );

    return _paymentRepository.create(payment);
  }

  Future<String> createInvoice({
    required Billing billingData,
  }) async {
    // final filter = getFilteredQuery('billing', {
    //   'customerId': {
    //     'isEqualTo': currentUser.id,
    //   },
    //   'status': {
    //     'isEqualTo': BillingStatus.belumBayar,
    //   },
    // });
    final getCustomer = await _userController.findOne(uid: currentUser.id);
    final getOrder = await _orderRepository.findOne(docId: billingData.orderId);
    final getpayment =
        await _paymentRepository.findOne(docId: billingData.paymentId);

    await _billingRepository.insert(billingData);
    final snapPayment = await _billingRepository.createVAPayment(
      user: getCustomer!,
      order: getOrder!,
      billing: billingData,
      payment: getpayment!,
    );

    return snapPayment['redirect_url'];
  }

  Future<Billing?> showBillingDetails(String billingId) {
    return _billingRepository.findOne(docId: billingId);
  }

  Stream<List<Billing>> showAllBilling(String customerId) {
    final filter = getFilteredQuery('billing', {
      'customerId': {
        'isEqualTo': customerId,
      },
    });
    return _billingRepository.findMany(filter);
  }
}

final billingControllerProvider = Provider.autoDispose((ref) {
  final currentUser = ref.watch(userDataProvider).value;

  return BillingController(ref, currentUser: currentUser!);
});
