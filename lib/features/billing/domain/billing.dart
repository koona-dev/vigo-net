import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:isp_app/features/billing/domain/billing_status.dart';

class Billing extends Equatable {
  final String? id;
  final String nomorTagihan;
  final String customerId;
  final String orderId;
  final String paymentId;
  final String? invoiceNumber;
  final BillingStatus status;
  final int totalBill;
  final int? denda;
  final Timestamp periodeTagihan;
  final Timestamp batasWaktuTagihan;

  const Billing({
    this.id,
    required this.nomorTagihan,
    required this.customerId,
    required this.orderId,
    required this.paymentId,
    this.invoiceNumber,
    required this.status,
    required this.totalBill,
    this.denda,
    required this.periodeTagihan,
    required this.batasWaktuTagihan,
  });

  factory Billing.fromMap(
    Map<String, dynamic> data,
  ) {
    return Billing(
      id: data['id'],
      nomorTagihan: data['nomorTagihan'],
      customerId: data['customerId'],
      orderId: data['orderId'],
      paymentId: data['paymentId'],
      denda: data['denda'] ?? 0,
      invoiceNumber: data['invoiceNumber'],
      status: BillingStatus.values
          .firstWhere((element) => element.name == data['status']),
      batasWaktuTagihan: data['batasWaktuTagihan'],
      periodeTagihan: data['periodeTagihan'],
      totalBill: data['totalBill'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomorTagihan': nomorTagihan,
      'orderId': orderId,
      'paymentId': paymentId,
      'invoiceNumber': invoiceNumber,
      'customerId': customerId,
      'totalBill': totalBill,
      'denda': denda,
      'periodeTagihan': periodeTagihan,
      'batasWaktuTagihan': batasWaktuTagihan,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
        id,
        nomorTagihan,
        orderId,
        paymentId,
        invoiceNumber,
        totalBill,
        denda,
        periodeTagihan,
        batasWaktuTagihan,
        customerId,
        status,
      ];
}
