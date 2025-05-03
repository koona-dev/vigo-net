import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:vigo_net_mobile/features/billing/domain/payment.dart';
import 'package:vigo_net_mobile/features/user_management/domain/customer.dart';

class Billing extends Equatable {
  final String? id;
  final String nomorTagihan;
  final String customerId;
  final String orderId;
  final String paymentId;
  final Customer? customer;
  final Payment? payment;
  final String? invoiceNumber;
  final BillingStatus status;
  final int totalBill;
  final int? denda;
  final Timestamp tanggalTagihan;

  const Billing({
    this.id,
    required this.nomorTagihan,
    required this.customerId,
    required this.orderId,
    required this.paymentId,
    this.customer,
    this.payment,
    this.invoiceNumber,
    required this.status,
    required this.totalBill,
    this.denda,
    required this.tanggalTagihan,
  });

  Billing copyWith({
    String? invoiceNumber,
    BillingStatus? status,
    int? totalBill,
    int? denda,
    Timestamp? tanggalTagihan,
  }) {
    return Billing(
      nomorTagihan: nomorTagihan,
      customerId: customerId,
      orderId: orderId,
      paymentId: paymentId,
      customer: customer,
      payment: payment,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      status: status ?? this.status,
      totalBill: totalBill ?? this.totalBill,
      denda: denda ?? this.denda,
      tanggalTagihan: tanggalTagihan ?? this.tanggalTagihan,
    );
  }

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
      tanggalTagihan: data['tanggalTagihan'],
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
      'tanggalTagihan': tanggalTagihan,
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
        customer,
        payment,
        totalBill,
        denda,
        tanggalTagihan,
        customerId,
        status,
      ];
}

enum BillingStatus {
  belumBayar,
  lunas,
  expired,
}
